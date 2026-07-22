// Path: lib/features/auth/pages/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/app_routes.dart';
import 'package:joojo_chat/features/agency/providers/auth_provider.dart';
import 'package:joojo_chat/features/auth/widgets/login_form_fields.dart';
import 'package:joojo_chat/features/auth/widgets/login_social_buttons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color purpleGlow = Color(0xff8A5CFF);
    
    // 🌟 تم تثبيت وتصحيح متغير الـ authState هنا في رأس دالة البناء لمنع الـ Undefined name
    final authState = ref.watch(authProvider);

    // مراقبة استجابة السيرفر لعرض الأخطاء والتوجيه للرئيسية حياً عند النجاح
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
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      body: Stack(
        children: [
          // 1. قراءة ملف صورة الخلفية الثابتة محلياً من مجلد backgrounds بالملي
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/login_bg.png',
            ),
          ),

          // 2. طبقة تعتيم زجاجية انسيابية داكنة لضمان وضوح نصوص الإدخال الفخمة
          Positioned.fill(
            child: Container(
              color: const Color(0xff090514).withValues(alpha: 0.82),
            ),
          ),

          // 3. المحتوى التفاعلي الكلي المدفوع لأسفل الشاشة
          Positioned.fill(
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(flex: 3),

                                // 4. قراءة ملف صورة الشعار (الـ Logo) الثابتة محلياً من مجلد images
                                Image.asset(
                                  'assets/images/logo.png',
                                  width: 95,
                                  height: 90,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 20),
                                // نصوص الترحيب بخط القاهرة القياسي بالمنصة
                                const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold, 
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'مرحباً بك مجدداً',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.45), 
                                    fontSize: 12, 
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // ويدجت الحقول النصية لبيانات الدخول المنفصلة
                                LoginFormFields(
                                  emailController: _emailController,
                                  passwordController: _passwordController,
                                ),
                                const SizedBox(height: 24),

                                // زر تسجيل الدخول المطور والمتفاعل مع السيرفر حياً
                                GestureDetector(
                                  onTap: authState.isLoading
                                      ? null 
                                      : () {
                                          if (_formKey.currentState!.validate()) {
                                            ref.read(authProvider.notifier).signInWithEmail(
                                                  email: _emailController.text.trim(),
                                                  password: _passwordController.text.trim(),
                                                );
                                          }
                                        },
                                  child: Container(
                                    width: double.infinity,
                                    height: 46,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xff8A5CFF), Color(0xff5214CC)],
                                      ),
                                      borderRadius: BorderRadius.circular(23),
                                      boxShadow: [
                                        BoxShadow(
                                          color: purpleGlow.withValues(alpha: 0.25), 
                                          blurRadius: 12,
                                        ),
                                      ],
                                    ),
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
                                            'تسجيل الدخول',
                                            style: TextStyle(
                                              color: Colors.white, 
                                              fontSize: 13, 
                                              fontWeight: FontWeight.bold, 
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // قسم أزرار التواصل الاجتماعي والتسجيل برقم الهاتف
                                const LoginSocialButtons(),
                                
                                // مسافة مرنة سفلية لضمان تجمع الأزرار فوق بعضها بذكاء قبل نهاية الشاشة
                                const Spacer(),
                                const SizedBox(height: 16),

                                // سطر الانتقال والتحويل لإنشاء حساب جديد بأسفل كبسولة الواجهة
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ليس لديك حساب؟ ', 
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.45), 
                                        fontSize: 11, 
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.push(AppRoutes.register);
                                      },
                                      child: const Text(
                                        'إنشاء حساب', 
                                        style: TextStyle(
                                          color: Color(0xffA277FF), 
                                          fontSize: 11, 
                                          fontWeight: FontWeight.bold, 
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
