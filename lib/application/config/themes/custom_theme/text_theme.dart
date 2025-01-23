import 'package:flutter/material.dart';

import 'color_theme.dart';

final textThemeLight = TextTheme(
  displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: colorSchemeLight.onSurface),
  displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colorSchemeLight.onSurface),
  displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorSchemeLight.onSurface),
  headlineLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorSchemeLight.onSurface),
  headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeLight.onSurface),
  headlineSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colorSchemeLight.onSurface),
  titleLarge: TextStyle(fontSize: 20, color: colorSchemeLight.onSurface),
  titleMedium: TextStyle(fontSize: 18, color: colorSchemeLight.onSurface),
  titleSmall: TextStyle(fontSize: 16, color: colorSchemeLight.onSurface),
  bodyLarge: TextStyle(fontSize: 16, color: colorSchemeLight.onSurface),
  bodyMedium: TextStyle(fontSize: 14, color: colorSchemeLight.onSurface),
  bodySmall: TextStyle(fontSize: 12, color: colorSchemeLight.onSurface),
  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeLight.onSurface),
);

final textThemeDark = TextTheme(
  displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: colorSchemeDark.onSurface),
  displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colorSchemeDark.onSurface),
  displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorSchemeDark.onSurface),
  headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorSchemeDark.onSurface),
  headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorSchemeDark.onSurface),
  headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeDark.onSurface),
  titleLarge: TextStyle(fontSize: 20, color: colorSchemeDark.onSurface),
  titleMedium: TextStyle(fontSize: 18, color: colorSchemeDark.onSurface),
  titleSmall: TextStyle(fontSize: 16, color: colorSchemeDark.onSurface),
  bodyLarge: TextStyle(fontSize: 16, color: colorSchemeDark.onSurface),
  bodyMedium: TextStyle(fontSize: 14, color: colorSchemeDark.onSurface),
  bodySmall: TextStyle(fontSize: 12, color: colorSchemeDark.onSurface),
  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeDark.onSurface),
);