import 'package:flutter/material.dart';
import 'master_colors.dart';
import 'master_config.dart';

ThemeData themeData(ThemeData baseTheme) {
  // final baseTheme = ThemeData.light();

  // Dark Theme
  return baseTheme.copyWith(
    textTheme: TextTheme(
      displayLarge: TextStyle(
          //57 vertical 64 horzontial 0
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family),
      displayMedium: TextStyle(
          //45 vertical 52 horzontial 0
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family),
      displaySmall: TextStyle(
          //36 vertical 44 horzontial 0
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family),
      headlineLarge: TextStyle(
        //32 vertical 40 horzontial 0
        color: MasterColors.black,
        fontFamily: MasterConfig.default_font_family,
      ),
      headlineMedium: TextStyle(
        //28 vertical 36 horzontial 0
        color: MasterColors.black,
        fontFamily: MasterConfig.default_font_family,
      ),
      headlineSmall: TextStyle(
          //24 vertical 32 horzontial 0
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          //22 vertical 28 horzontial 0
          // height: 24,
          color: MasterColors.black,
          fontWeight: FontWeight.w600,
          fontFamily: MasterConfig.default_font_family),
      titleMedium: TextStyle(
          //16 vertical 24 horzontial 0.15
          fontSize: 18,
          color: MasterColors.secondary70,
          fontFamily: MasterConfig.default_font_family,
          fontWeight: FontWeight.w400),
      titleSmall: TextStyle(
          //14 vertical 20 horzontial 0.1
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family,
          fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
          //14 vertical 20 horzontial 0.1
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family),
      labelMedium: TextStyle(
          //12 vertical 16 horzontial 0.5
          color: MasterColors.black,
          // fontWeight: FontWeight.normal,
          fontFamily: MasterConfig.default_font_family),
      labelSmall: TextStyle(
          //11 vertical 16 horzontial 0.5
          fontFamily: MasterConfig.default_font_family,
          color: MasterColors.black),
      bodyLarge: TextStyle(
        //16 vertical 24 horzontial 0.15
        fontWeight: FontWeight.w400,
        color: MasterColors.black,
        fontFamily: MasterConfig.default_font_family,
      ),
      bodyMedium: TextStyle(
          //14 vertical 20 horzontial 0.25
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family,
          fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          //12 vertical 16 horzontial 0.4
          color: MasterColors.black,
          fontFamily: MasterConfig.default_font_family),
    ),
    unselectedWidgetColor: MasterColors.inActiveColor,
    iconTheme: IconThemeData(color: MasterColors.primaryDarkWhite),
  );
}
