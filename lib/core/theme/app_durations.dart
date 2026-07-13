abstract final class AppDurations {
  const AppDurations._();

  static const Duration instant = Duration.zero;
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration normal = Duration(milliseconds: 220);
  static const Duration medium = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 480);
  static const Duration extraSlow = Duration(milliseconds: 700);

  static const Duration splashMinimum = Duration(milliseconds: 900);
  static const Duration toast = Duration(seconds: 3);
  static const Duration debounce = Duration(milliseconds: 350);
  static const Duration throttle = Duration(milliseconds: 500);
  static const Duration networkTimeout = Duration(seconds: 30);
}
