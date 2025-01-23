import 'package:flutter/material.dart';

import 'color_theme.dart';

final cardThemeLight = CardTheme(
  color: colorSchemeLight.surface,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
);

final cardThemeDark = CardTheme(
  color: colorSchemeDark.surface,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
);
