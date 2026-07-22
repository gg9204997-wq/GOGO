// Path: lib/core/widgets/app_scaffold.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:joojo_chat/core/providers/background_provider.dart';
import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/widgets/background_config.dart';

class AppScaffold extends ConsumerWidget { // 💡 تحويل الكلاس إلى ConsumerWidget
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final PageBackgroundConfig? backgroundConfig; 

  const AppScaffold({
    required this.body, 
    super.key,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.backgroundConfig, 
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) { // 💡 إضافة معامل الـ WidgetRef هنا
    // إذا لم تقم بتمرير إعدادات مخصصة للصفحة، سيتم استخدام التكوين الافتراضي (defaultBg)
    final config = backgroundConfig ?? PageBackgroundConfig.defaultBg;

    // 💡 مراقبة حالة نوع الخلفية القادمة بشكل حي ومباشر من قاعدة بيانات Supabase
    final backgroundState = ref.watch(appBackgroundProvider);

    // إذا كانت القيمة لم تُحمل بعد من السيرفر، ستكون false (ثابتة) كوضع افتراضي مؤقت
    final bool isAnimated = backgroundState.value ?? false;

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      // الـ Stack يعمل دائماً لتأمين الخلفية المطلوبة (ثابتة أو متحركة) بشكل مرن
      body: Stack(
        children: [
          // 1. طبقة الخلفية الذكية: تفحص المتغير القادم من السيرفر لتعرض المتحرك أو الثابت فوراً
          Positioned.fill(
            child: isAnimated
                ? Lottie.asset(config.animatedPath, fit: BoxFit.cover, repeat: true)
                : Image.asset(config.staticPath, fit: BoxFit.cover),
          ),
          
          // 2. طبقة محتوى الصفحة الخاصة بك مع الحفاظ على شفافية الـ Scaffold لتظهر الخلفية من ورائه
          Positioned.fill(
            child: Theme(
              data: Theme.of(context).copyWith(
                scaffoldBackgroundColor: Colors.transparent,
              ),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
