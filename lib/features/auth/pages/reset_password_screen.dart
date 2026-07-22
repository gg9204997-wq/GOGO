// Path: lib/features/auth/pages/reset_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/app_routes.dart';
import 'package:joojo_chat/features/agency/providers/auth_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  static const Color _purpleGlow = Color(0xff8A5CFF);

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // 🌟 الاستماع اللحظي للتحويل التلقائي للرئيسية وإشعار المستخدم فور نجاح التحديث بالسيرفر
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            backgroundColor: Colors.red.withValues(alpha: 0.8),
          ),
        );
      }
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('🎉 تم تحديث كلمة المرور بنجاح! مبروك الولوج المباشر', style: TextStyle(fontFamily: 'Cairo'))),
        );
        context.go(AppRoutes.home); // التوجيه الفوري للـ HomePage حياً بالملي
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'إعادة تعيين كلمة المرور',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 24),

            _buildInputField(controller: _newPassController, hint: 'كلمة المرور الجديدة'),
            const SizedBox(height: 12),

            _buildInputField(controller: _confirmPassController, hint: 'تأكيد كلمة المرور'),
            const SizedBox(height: 30),

            GestureDetector(
              onTap: authState.isLoading
                  ? null
                  : () {
                      if (_newPassController.text.trim().isEmpty || _confirmPassController.text.trim().isEmpty) {
                        return;
                      }
                      if (_newPassController.text != _confirmPassController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('كلمتا المرور غير متطابقتين!', style: TextStyle(fontFamily: 'Cairo'))),
                        );
                        return;
                      }
                      // 🌟 إرسال طلب التحديث الفوري لـ كلمة المرور لـ Supabase بالملي
                      ref.read(authProvider.notifier).updateNewPassword(
                            newPassword: _newPassController.text.trim(),
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
                        'تغيير كلمة المرور',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _purpleGlow.withValues(alpha: 0.15)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(color: Colors.white, fontSize: 12.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 11, fontFamily: 'Cairo'),
          prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xffA277FF), size: 18),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        ),
      ),
    );
  }
}
