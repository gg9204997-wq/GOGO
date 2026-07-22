// Path: lib/features/auth/pages/phone_login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/app_routes.dart';
import 'package:joojo_chat/features/agency/providers/auth_provider.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  static const Color _purpleGlow = Color(0xff8A5CFF);

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // 🌟 الاستماع الفوري لحالة الـ Auth للتحويل التلقائي لشاشة الـ OTP فور نجاح الإرسال من السيرفر
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            backgroundColor: Colors.red.withValues(alpha: 0.8),
          ),
        );
      }
      if (next.isSuccess && next.user == null) {
        // إذا نجح السيرفر في إرسال الـ OTP، ننقل المستخدم فوراً لصفحة إدخال الرمز بالملي
        context.push(AppRoutes.otp);
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
            const SizedBox(height: 10),
            const Text(
              'تسجيل الدخول برقم الهاتف',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 4),
            Text(
              'أدخل رقم هاتفك لتلقي كود التفعيل',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 11, fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xff120D1F),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _purpleGlow.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Text('🇸🇦 السعودية', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Cairo')),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down_rounded, color: Colors.white30),
                  Container(width: 1, height: 20, color: Colors.white10, margin: const EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'رقم الهاتف (مثل: 512345678)',
                        hintStyle: TextStyle(color: Colors.white24, fontSize: 11, fontFamily: 'Cairo'),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            GestureDetector(
              onTap: authState.isLoading
                  ? null
                  : () {
                      if (_phoneController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('يرجى إدخال رقم هاتف صحيح أولاً', style: TextStyle(fontFamily: 'Cairo'))),
                        );
                        return;
                      }
                      // 🌟 ربط وإرسال طلب الـ OTP الحقيقي لـ Supabase عبر الـ Provider بالملي بالصيغة الدولية
                      ref.read(authProvider.notifier).sendOtpToPhone(
                            phoneNumber: '+966${_phoneController.text.trim()}',
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
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'إرسال رمز التحقق',
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
