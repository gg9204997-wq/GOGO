import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_theme_data.dart';

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get light => AppThemeData.light;

  static ThemeData get dark => AppThemeData.dark;
}
