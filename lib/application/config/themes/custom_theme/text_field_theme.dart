import 'package:flutter/material.dart';

import 'color_theme.dart';

final inputDecorationThemeLight = InputDecorationTheme(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colorSchemeLight.secondary),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeLight.primary),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeLight.primary),
    borderRadius: BorderRadius.circular(12),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeLight.error),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeLight.error),
    borderRadius: BorderRadius.circular(12),
  ),
  fillColor: colorSchemeLight.surface,
  filled: true,
  hintStyle: TextStyle(color: colorSchemeLight.onSurface.withOpacity(0.6)),
  labelStyle: TextStyle(color: colorSchemeLight.onSurface),
  errorStyle: TextStyle(color: colorSchemeLight.error),
);

final inputDecorationThemeDark = InputDecorationTheme(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colorSchemeDark.secondary),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeDark.primary),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeDark.primary),
    borderRadius: BorderRadius.circular(12),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeDark.error),
    borderRadius: BorderRadius.circular(12),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorSchemeDark.error),
    borderRadius: BorderRadius.circular(12),
  ),
  fillColor: colorSchemeDark.surface,
  filled: true,
  hintStyle: TextStyle(color: colorSchemeDark.onSurface.withOpacity(0.6)),
  labelStyle: TextStyle(color: colorSchemeDark.onSurface),
  errorStyle: TextStyle(color: colorSchemeDark.error),
);
