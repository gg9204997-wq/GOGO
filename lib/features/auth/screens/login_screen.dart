import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/auth/providers/auth_provider.dart';
import 'package:joojo_chat/features/auth/widgets/auth_button.dart';
import 'package:joojo_chat/features/auth/widgets/auth_footer.dart';
import 'package:joojo_chat/features/auth/widgets/auth_logo.dart';
import 'package:joojo_chat/features/auth/widgets/auth_text_field.dart';
import 'package:joojo_chat/features/auth/widgets/password_field.dart';
import 'package:joojo_chat/features/auth/widgets/social_buttons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      loading = true;
    });

    final success = await ref.read(authProvider.notifier).login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (success) {
      /// هنضيف الانتقال للصفحة الرئيسية بعدين
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('فشل تسجيل الدخول'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F111D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              const AuthLogo(),

              const SizedBox(height: 45),

              AuthTextField(
                controller: emailController,
                hint: 'البريد الإلكتروني',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              PasswordField(
                controller: passwordController,
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // لاحقاً
                  },
                  child: const Text(
  'نسيت كلمة المرور؟',
),
                ),
              ),

              const SizedBox(height: 10),

              AuthButton(
                text: 'تسجيل الدخول',
                loading: loading,
                onPressed: login,
              ),

              const SizedBox(height: 30),

              SocialButtons(
                onGoogle: () {},
                onFacebook: () {},
              ),

              const SizedBox(height: 30),

              AuthFooter(
                onRegister: () {
                  // لاحقاً
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}