import 'package:flutter/material.dart';
import 'package:todo_app/application/config/themes/custom_theme/text_theme.dart';

import 'color_theme.dart';

final appBarThemeLight = AppBarTheme(
  color: colorSchemeLight.primary,
  iconTheme: IconThemeData(color: colorSchemeLight.onPrimary),
  titleTextStyle: textThemeLight.headlineLarge
);

final appBarThemeDark = AppBarTheme(
  color: colorSchemeDark.primary,
  iconTheme: IconThemeData(color: colorSchemeDark.onPrimary),
  titleTextStyle: textThemeDark.headlineLarge
);
