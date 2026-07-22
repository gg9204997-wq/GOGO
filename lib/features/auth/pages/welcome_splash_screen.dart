// Path: lib/features/auth/pages/welcome_splash_screen.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeSplashScreen extends StatefulWidget {
  const WelcomeSplashScreen({super.key});

  @override
  State<WelcomeSplashScreen> createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen> {
  String? _dynamicSplashImageUrl;
  bool _isLoadingImage = true;

  @override
  void initState() {
    super.initState();
    _fetchDynamicSplashFromServer();
  }

  /// 🌐 دالة جلب صورة الترحيب المحدثة من السيرفر والتي يتحكم بها المدير
  Future<void> _fetchDynamicSplashFromServer() async {
    try {
      final supabase = Supabase.instance.client;
      
      final data = await supabase
          .from('app_settings')
          .select('splash_image_url')
          .maybeSingle();

      if (data != null && data['splash_image_url'] != null) {
        if (mounted) {
          setState(() {
            _dynamicSplashImageUrl = data['splash_image_url'].toString();
            _isLoadingImage = false;
          });
        }
      } else {
        if (mounted) setState(() => _isLoadingImage = false);
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingImage = false);
    }

    // 🌟 ميكانيزم التوجيه الفعلي: تفعيل أمر النقل والانتقال المباشر لصفحة تسجيل الدخول فور انتهاء وقت التحميل بالملي
    Future<void>.delayed(const Duration(milliseconds: 3500), () {
      if (!mounted) return;
      context.go(AppRoutes.login); // تفعيل الربط الحقيقي بالراوتر الحين لتخطي شاشة الـ Splash بنجاح
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color goldGlow = Color(0xffFFD700);

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      body: Stack(
        children: [
          // غلاف شاشة الترحيب الديناميكي
          Positioned.fill(
            child: _dynamicSplashImageUrl != null && _dynamicSplashImageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: _dynamicSplashImageUrl!,
                    fit: BoxFit.cover, 
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => _buildDefaultBackgroundGradient(),
                  )
                : _buildDefaultBackgroundGradient(), 
          ),

          // طبقة تعتيم زجاجية انسيابية
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    const Color(0xff090514).withValues(alpha: 0.85),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // محتويات الشاشة الأساسية
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: goldGlow.withValues(alpha: 0.4), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: goldGlow.withValues(alpha: 0.15),
                        blurRadius: 25,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'J',
                        style: TextStyle(
                          color: goldGlow,
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      Text(
                        'JOOJO\nCHAT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: goldGlow,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 2),
                
                const Text(
                  'تواصل .. تعرف .. اربط',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white10,
                      color: const Color(0xff8A5CFF),
                      value: _isLoadingImage ? null : null, 
                      minHeight: 4,
                    ),
                  ),
                ),
                
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultBackgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            const Color(0xff1E0B36).withValues(alpha: 0.6),
            const Color(0xff090514),
          ],
          radius: 1.2,
        ),
      ),
    );
  }
}
