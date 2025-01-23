import 'package:flutter/material.dart';
import 'package:todo_app/application/config/themes/custom_theme/text_theme.dart';

import 'color_theme.dart';

final elevatedButtonThemeLight = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
    backgroundColor: WidgetStateProperty.all(colorSchemeLight.primary),
    foregroundColor: WidgetStateProperty.all(colorSchemeLight.onPrimary),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    )),
    textStyle: WidgetStateProperty.all(textThemeLight.headlineSmall),
    elevation: WidgetStateProperty.all(5),
  ),
);

final elevatedButtonThemeDark = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
    backgroundColor: WidgetStateProperty.all(colorSchemeDark.primary),
    foregroundColor: WidgetStateProperty.all(colorSchemeDark.onPrimary),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    )),
    textStyle: WidgetStateProperty.all(textThemeDark.headlineSmall),
    elevation: WidgetStateProperty.all(5),
  ),
);
