import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

abstract final class AppGradients {
  const AppGradients._();

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.primary,
      AppColors.secondary,
    ],
  );

  static const LinearGradient roomLive = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.voiceLive,
      AppColors.primary,
      AppColors.secondary,
    ],
  );

  static const LinearGradient vip = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.vipGold,
      AppColors.tertiaryLight,
    ],
  );

  static const LinearGradient diamond = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppColors.diamond,
      AppColors.secondaryLight,
    ],
  );

  static const LinearGradient darkSurface = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      AppColors.surfaceVariant,
      AppColors.background,
    ],
  );

  static const LinearGradient lightSurface = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      AppColors.white,
      AppColors.backgroundLight,
    ],
  );
}
