import 'package:flutter/material.dart';
import 'color_theme.dart';

final switchThemeLight = SwitchThemeData(
  thumbColor: WidgetStateProperty.all(colorSchemeLight.primary),
  trackColor: WidgetStateProperty.all(colorSchemeLight.secondary.withOpacity(0.5)),
  overlayColor: WidgetStateProperty.all(colorSchemeLight.primary.withOpacity(0.2)),
  splashRadius: 20.0,
);

final switchThemeDark = SwitchThemeData(
  thumbColor: WidgetStateProperty.all(colorSchemeDark.primary),
  trackColor: WidgetStateProperty.all(colorSchemeDark.secondary.withOpacity(0.5)),
  overlayColor: WidgetStateProperty.all(colorSchemeDark.primary.withOpacity(0.2)),
  splashRadius: 20.0,
);
