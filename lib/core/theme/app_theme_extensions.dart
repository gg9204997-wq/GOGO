import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_gradients.dart';
import 'package:joojo_chat/core/theme/app_shadows.dart';

@immutable
final class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.primaryGradient,
    required this.surfaceGradient,
    required this.cardShadow,
    required this.glassShadow,
  });

  final LinearGradient primaryGradient;
  final LinearGradient surfaceGradient;
  final List<BoxShadow> cardShadow;
  final List<BoxShadow> glassShadow;

  static const AppThemeExtension light = AppThemeExtension(
    primaryGradient: AppGradients.primary,
    surfaceGradient: AppGradients.lightSurface,
    cardShadow: AppShadows.soft,
    glassShadow: AppShadows.glass,
  );

  static const AppThemeExtension dark = AppThemeExtension(
    primaryGradient: AppGradients.roomLive,
    surfaceGradient: AppGradients.darkSurface,
    cardShadow: AppShadows.card,
    glassShadow: AppShadows.glass,
  );

  @override
  AppThemeExtension copyWith({
    LinearGradient? primaryGradient,
    LinearGradient? surfaceGradient,
    List<BoxShadow>? cardShadow,
    List<BoxShadow>? glassShadow,
  }) {
    return AppThemeExtension(
      primaryGradient: primaryGradient ?? this.primaryGradient,
      surfaceGradient: surfaceGradient ?? this.surfaceGradient,
      cardShadow: cardShadow ?? this.cardShadow,
      glassShadow: glassShadow ?? this.glassShadow,
    );
  }

  @override
  AppThemeExtension lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      primaryGradient: primaryGradient,
      surfaceGradient: surfaceGradient,
      cardShadow: BoxShadow.lerpList(cardShadow, other.cardShadow, t) ??
          cardShadow,
      glassShadow: BoxShadow.lerpList(glassShadow, other.glassShadow, t) ??
          glassShadow,
    );
  }
}
