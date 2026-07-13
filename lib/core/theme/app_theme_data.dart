import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';
import 'package:joojo_chat/core/theme/app_theme_extensions.dart';
import 'package:joojo_chat/core/theme/components/appbar_theme.dart';
import 'package:joojo_chat/core/theme/components/bottom_navigation_theme.dart';
import 'package:joojo_chat/core/theme/components/bottom_sheet_theme.dart';
import 'package:joojo_chat/core/theme/components/button_theme.dart';
import 'package:joojo_chat/core/theme/components/card_theme.dart';
import 'package:joojo_chat/core/theme/components/checkbox_theme.dart';
import 'package:joojo_chat/core/theme/components/chip_theme.dart';
import 'package:joojo_chat/core/theme/components/dialog_theme.dart';
import 'package:joojo_chat/core/theme/components/divider_theme.dart';
import 'package:joojo_chat/core/theme/components/icon_theme.dart';
import 'package:joojo_chat/core/theme/components/input_theme.dart';
import 'package:joojo_chat/core/theme/components/navigation_theme.dart';
import 'package:joojo_chat/core/theme/components/progress_theme.dart';
import 'package:joojo_chat/core/theme/components/radio_theme.dart';
import 'package:joojo_chat/core/theme/components/scrollbar_theme.dart';
import 'package:joojo_chat/core/theme/components/slider_theme.dart';
import 'package:joojo_chat/core/theme/components/snackbar_theme.dart';
import 'package:joojo_chat/core/theme/components/switch_theme.dart';
import 'package:joojo_chat/core/theme/components/text_selection_theme.dart';

abstract final class AppThemeData {
  const AppThemeData._();

  static ThemeData get light {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      canvasColor: AppColors.backgroundLight,
      textTheme: AppTextStyles.textTheme(AppColors.textPrimaryLight),
      primaryTextTheme: AppTextStyles.textTheme(AppColors.textPrimaryLight),
      appBarTheme: AppAppBarTheme.light.copyWith(
        titleTextStyle: AppAppBarTheme.lightTitle,
      ),
      bottomNavigationBarTheme: AppBottomNavigationTheme.light,
      navigationBarTheme: AppBottomNavigationTheme.navigationLight,
      navigationRailTheme: AppNavigationTheme.railLight,
      bottomSheetTheme: AppBottomSheetTheme.light,
      elevatedButtonTheme: AppButtonTheme.light,
      filledButtonTheme: AppButtonTheme.filled,
      outlinedButtonTheme: AppButtonTheme.outlined,
      textButtonTheme: AppButtonTheme.text,
      iconButtonTheme: AppButtonTheme.icon,
      cardTheme: AppCardTheme.light,
      checkboxTheme: AppCheckboxTheme.light,
      chipTheme: AppChipTheme.light,
      dialogTheme: AppDialogTheme.light,
      dividerTheme: AppDividerTheme.light,
      iconTheme: AppIconTheme.light,
      inputDecorationTheme: AppInputTheme.light,
      progressIndicatorTheme: AppProgressTheme.light,
      radioTheme: AppRadioTheme.light,
      scrollbarTheme: AppScrollbarTheme.light,
      sliderTheme: AppSliderTheme.light,
      snackBarTheme: AppSnackBarTheme.light,
      switchTheme: AppSwitchTheme.light,
      textSelectionTheme: AppTextSelectionTheme.light,
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtension.light,
      ],
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
    );
  }

  static ThemeData get dark {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryDark,
      onPrimaryContainer: AppColors.white,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.onSecondaryContainer,
      secondaryContainer: AppColors.secondaryDark,
      onSecondaryContainer: AppColors.white,
      tertiary: AppColors.tertiaryLight,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryDark,
      onTertiaryContainer: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      textTheme: AppTextStyles.textTheme(AppColors.textPrimary),
      primaryTextTheme: AppTextStyles.textTheme(AppColors.textPrimary),
      appBarTheme: AppAppBarTheme.dark.copyWith(
        titleTextStyle: AppAppBarTheme.darkTitle,
      ),
      bottomNavigationBarTheme: AppBottomNavigationTheme.dark,
      navigationBarTheme: AppBottomNavigationTheme.navigationDark,
      navigationRailTheme: AppNavigationTheme.railDark,
      bottomSheetTheme: AppBottomSheetTheme.dark,
      elevatedButtonTheme: AppButtonTheme.dark,
      filledButtonTheme: AppButtonTheme.filled,
      outlinedButtonTheme: AppButtonTheme.outlined,
      textButtonTheme: AppButtonTheme.text,
      iconButtonTheme: AppButtonTheme.icon,
      cardTheme: AppCardTheme.dark,
      checkboxTheme: AppCheckboxTheme.dark,
      chipTheme: AppChipTheme.dark,
      dialogTheme: AppDialogTheme.dark,
      dividerTheme: AppDividerTheme.dark,
      iconTheme: AppIconTheme.dark,
      inputDecorationTheme: AppInputTheme.dark,
      progressIndicatorTheme: AppProgressTheme.dark,
      radioTheme: AppRadioTheme.dark,
      scrollbarTheme: AppScrollbarTheme.dark,
      sliderTheme: AppSliderTheme.dark,
      snackBarTheme: AppSnackBarTheme.dark,
      switchTheme: AppSwitchTheme.dark,
      textSelectionTheme: AppTextSelectionTheme.dark,
      extensions: const <ThemeExtension<dynamic>>[
        AppThemeExtension.dark,
      ],
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
    );
  }

  static ShapeBorder roundedShape(BorderRadius borderRadius) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius,
    );
  }

  static ShapeBorder defaultRoundedShape() {
    return roundedShape(AppRadius.radiusXL);
  }
}
