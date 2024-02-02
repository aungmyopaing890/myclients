import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalization extends ChangeNotifier {
  AppLocalization._singleton();

  static AppLocalization get instance => AppLocalization._singleton();

  static late Locale _locale;

  static List<Locale> _supportedLocales = <Locale>[];

  static Map<String, String> _localizedString = <String, String>{};

  static String _changesCode = '';

  String storeLocaleKey = 'app_locale';

  String storeSupportedLocalesKey = 'app_supportedLocales';

  String storeHasChangesFromServerKey = 'app_language_translation_changes';

  String storeServerTranslationChangesCode =
      'app_server_translation_changes_code';

  Locale get currentLocale => _locale;

  List<Locale> get supportedLocales => _supportedLocales;

  String get code => _changesCode;

  /// a method that must be initialized in main method of the app
  Future<void> ensureInitialized() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? localeString = pref.getString(storeLocaleKey);
    final String? changesCode =
        pref.getString(storeServerTranslationChangesCode);

    /// App Locale will set to [en] as default if [localeString] is null.
    if (localeString == null) {
      _locale = const Locale('en', 'US');
    } else {
      final Locale locale = fromEncodedString(localeString);
      _locale = locale;
    }

    if (changesCode != null) {
      _changesCode = changesCode;
    }

    List<String>? supportedLanguageCode =
        pref.getStringList(storeSupportedLocalesKey);

    supportedLanguageCode ??= <String>[
      'en',
      'my',
      'ch',
    ];
    _supportedLocales = supportedLanguageCode
        .map((String langCode) => Locale(langCode))
        .toList();

    await _initLoad();
  }

  Future<void> updateChangesCode(String code) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(storeServerTranslationChangesCode, code);
  }

  Future<void> _initLoad() async {
    debugPrint('\u001b[32m ⌛ Loading Translation from Assets ⌛ \u001b[0m');
    await loadFromAsset();
  }

  /// Change app locale
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    await loadFromAsset();
    // // await loadTranslationWithCode(code, id);
    await _saveCurrentLocale(locale);
    notifyListeners();
  }

  // Change app supportedLocales
  Future<void> setSupportedLocales(List<String> languageCodes) async {
    for (String langCode in languageCodes) {
      _supportedLocales.add(Locale(langCode));
      _supportedLocales.toSet();
    }
    notifyListeners();
    await _saveSupportedLocale(languageCodes);
  }

  /// Save languageCodeList to SharedPref
  Future<void> _saveSupportedLocale(List<String> languageCode) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(storeSupportedLocalesKey, languageCode);
  }

  /// Save languageCode to SharedPref
  Future<void> _saveCurrentLocale(Locale locale) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(storeLocaleKey, locale.toEncodedString());
  }

  Future<void> loadFromAsset() async {
    final String translation = await rootBundle
        .loadString('assets/lang/${_locale.languageCode}_tran.json');
    final Map<String, dynamic> jsonMap = json.decode(translation);

    /// Mapping dynamic to String
    _localizedString = jsonMap.map((String key, dynamic value) {
      return MapEntry<String, String>(key, value.toString());
    });
    callLogger();
  }

  /// Uses to convert jsonEncodedString to Locale Object.
  Locale fromEncodedString(String encodedString) {
    final Map<String, dynamic> map = jsonDecode(encodedString);
    final Locale locale = Locale(
      map['language_code'],
      map['country_code'],
    );
    return locale;
  }

  String translate(String key) {
    return _localizedString[key].validate(key);
  }

  /// Logger
  void callLogger() {
    debugPrint(
        '\u001b[32m 🌎 App Localization Loaded -- ${_locale.languageCode}  🌎 \u001b[0m');
  }
}

// Extension

extension Translate on String {
  ///Core method to translate your language keys
  String get tr => AppLocalization.instance.translate(this);
}

extension LocaleExtention on Locale {
  /// Encoder Function to store a locale as a String.
  String toEncodedString() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['language_code'] = languageCode;
    map['country_code'] = countryCode;
    final String encodedString = jsonEncode(map);
    return encodedString;
  }

  /// Uses to convert Locale object to Map Object.
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['language_code'] = languageCode;
    map['country_code'] = countryCode;
    return map;
  }
}

extension Validate on String? {
  /// Uses to check whether your language key is null or not.
  String validate(String key) {
    if (this == null || (this != null && this!.isEmpty)) {
      return key;
    }
    return this!;
  }
}
