// Path: lib/core/widgets/background_config.dart

class PageBackgroundConfig {
  final String staticPath;    
  final String animatedPath;  

  const PageBackgroundConfig({
    required this.staticPath,
    required this.animatedPath,
  });

  // 💡 تم تحويل جميع النصوص إلى علامات اقتباس مفردة لتختفي التحذيرات الثمانية تماماً
  static const PageBackgroundConfig login = PageBackgroundConfig(
    staticPath: 'assets/backgrounds/login_bg.png',
    animatedPath: 'assets/lottie/login_animation.json',
  );

  static const PageBackgroundConfig register = PageBackgroundConfig(
    staticPath: 'assets/backgrounds/register_bg.png',
    animatedPath: 'assets/lottie/register_animation.json',
  );

  static const PageBackgroundConfig room = PageBackgroundConfig(
    staticPath: 'assets/backgrounds/room_bg.png',
    animatedPath: 'assets/lottie/audio_wave_bg.json',
  );

  static const PageBackgroundConfig defaultBg = PageBackgroundConfig(
    staticPath: 'assets/backgrounds/home_bg.png',
    animatedPath: 'assets/lottie/home_animation.json',
  );
}
