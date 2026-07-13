import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_theme_extensions.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  AppThemeExtension get appTheme =>
      theme.extension<AppThemeExtension>() ?? AppThemeExtension.light;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  bool get isTablet => screenWidth >= AppSizes.tabletBreakpoint;

  bool get isDesktop => screenWidth >= AppSizes.desktopBreakpoint;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
