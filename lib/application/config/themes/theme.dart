import 'package:flutter/material.dart';
import 'custom_theme/app_bar_theme.dart';
import 'custom_theme/card_theme.dart';
import 'custom_theme/color_theme.dart';
import 'custom_theme/elevated_button_theme.dart';
import 'custom_theme/switch_theme.dart';
import 'custom_theme/text_field_theme.dart';
import 'custom_theme/text_theme.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: appBarThemeLight,
    textTheme: textThemeLight,
    colorScheme: colorSchemeLight,
    elevatedButtonTheme: elevatedButtonThemeLight,
    inputDecorationTheme: inputDecorationThemeLight,
    switchTheme: switchThemeLight,
    cardTheme: cardThemeLight);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: appBarThemeDark,
  textTheme: textThemeDark,
  colorScheme: colorSchemeDark,
  elevatedButtonTheme: elevatedButtonThemeDark,
  inputDecorationTheme: inputDecorationThemeDark,
  switchTheme: switchThemeDark,
  cardTheme: cardThemeDark,
);
