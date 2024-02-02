// ignore_for_file: constant_identifier_names

import 'package:myclients/modules/language/core/view_object.dart/language.dart';

class MasterConfig {
  MasterConfig._();

  ///
  /// AppName

  static const String app_name = 'My Clients';

  ///
  /// AppVersion

  static const String app_version = '1.0';

  ///
  /// Database Name

  static const String app_db_name = 'myaclient.db';

  ///
  /// Font Style
  static const String default_font_family = 'Mukta';

  ///
  /// Border radious

  static const double borderRadious = 20;

  static List<Language> supportedLanguages = [
    Language(name: 'English Language', languageCode: 'en'),
    Language(name: 'မြန်မာ ဘာသာစကား', languageCode: 'my'),
    Language(name: '中文', languageCode: 'ch'),
  ];

  static Language defaultLanguage =
      Language(name: 'English', languageCode: 'en');
}
