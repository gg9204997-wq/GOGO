import 'package:flutter/animation.dart';

import 'package:joojo_chat/core/theme/app_durations.dart';

abstract final class AppAnimation {
  const AppAnimation._();

  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve emphasizedCurve = Curves.easeInOutCubicEmphasized;
  static const Curve entranceCurve = Curves.easeOutBack;
  static const Curve exitCurve = Curves.easeInCubic;

  static const Duration fast = AppDurations.fast;
  static const Duration normal = AppDurations.normal;
  static const Duration medium = AppDurations.medium;
  static const Duration slow = AppDurations.slow;
}
