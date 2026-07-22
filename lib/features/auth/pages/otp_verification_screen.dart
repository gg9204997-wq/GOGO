// Path: lib/features/auth/pages/otp_verification_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/app_routes.dart';
import 'package:joojo_chat/features/agency/providers/auth_provider.dart';

// 🌟 تحويل كلاس الشاشة إلى ConsumerStatefulWidget لتمكين ربط الـ Provider وحقن جلسة الـ OTP بالسيرفر
class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  // مصفوفة متحكمات لـ 6 خانات رمز التحقق
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  static const Color _purpleGlow = Color(0xff8A5CFF);

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🌟 الاستماع اللحظي لحالة الـ Auth لمعرفة إذا كان السيرفر يحمل أو به خطأ
    final authState = ref.watch(authProvider);

    // 🌟 ميكانيزم مراقبة التغيرات (Listener) للتوجيه التلقائي بعد نجاح الـ OTP بالملي
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            backgroundColor: Colors.red.withValues(alpha: 0.8),
          ),
        );
      }
      if (next.isSuccess && next.user != null) {
        // إذا نجح الـ OTP، نوجه المستخدم فوراً للشاشة الرئيسية حياً
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '_controllers',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 4),
            Text(
              'أدخل رمز التحقق المرسل إلى رقم هاتفك',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 11, fontFamily: 'Cairo', height: 1.4),
            ),
            const SizedBox(height: 35),

            // حقول الـ OTP المكونة من 6 مربعات متجاورة رشيقة بالملي
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return Container(
                  width: 44,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xff120D1F),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _purpleGlow.withValues(alpha: 0.2)),
                  ),
                  child: TextFormField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus(); // الانتقal التلقائي للمربع التالي
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus(); // الرجوع للمربع السابق عند المسح
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // العداد الزمني التنازلي لإعادة الإرسال
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('إعادة إرسال الرمز ', style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 10.5, fontFamily: 'Cairo')),
                const Text('00:59', style: TextStyle(color: _purpleGlow, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 35),

            // زر تحقق الفوري المطور والمتفاعل مع السيرفر حياً
            GestureDetector(
              onTap: authState.isLoading
                  ? null
                  : () {
                      // 🌟 تجميع الكود المكون من 6 أرقام برمجياً بالملي لإرساله للسيرفر
                      final otpToken = _controllers.map((c) => c.text).join();
                      if (otpToken.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('يرجى إدخال رمز التحقق كاملاً المكون من 6 أرقام!', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // 🌟 إرسال طلب التحقق لـ Supabase (هنا يمكنك جلب رقم الهاتف الممرر من شاشة الهاتف السابقة)
                      ref.read(authProvider.notifier).verifyOtpCode(
                            phoneNumber: '+966512345678', // مثال، يتم تمريره ديناميكياً
                            token: otpToken,
                          );
                    },
              child: Container(
                width: double.infinity,
                height: 46,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xff8A5CFF), Color(0xff5214CC)]),
                  borderRadius: BorderRadius.circular(23),
                  boxShadow: [
                    BoxShadow(color: _purpleGlow.withValues(alpha: 0.25), blurRadius: 12),
                  ],
                ),
                alignment: Alignment.center,
                child: authState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'تحقق',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
