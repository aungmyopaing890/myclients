import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:myclients/modules/language/core/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:theme_manager/theme_manager.dart';

import 'config/master_theme_data.dart';
import 'config/route/router.dart';
import 'modules/common/core/provider/provider_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalization.instance.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _AppState();
}

class _AppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<AppLocalization>(
              create: (BuildContext context) {
            return AppLocalization.instance;
          }),
          ...providers,
        ],
        child: ThemeManager(
            defaultBrightnessPreference: BrightnessPreference.light,
            data: (Brightness brightness) => themeData(ThemeData.dark()),
            themedWidgetBuilder: (BuildContext context, ThemeData theme) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: theme,
                routeInformationProvider: router.routeInformationProvider,
                routerDelegate: router.routerDelegate,
                routeInformationParser: router.routeInformationParser,
                builder: BotToastInit(),
                title: 'app_name'.tr,
              );
            }));
  }
}
