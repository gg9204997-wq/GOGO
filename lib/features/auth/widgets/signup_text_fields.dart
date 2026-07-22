// Path: lib/features/auth/widgets/signup_text_fields.dart

import 'package:flutter/material.dart';

class SignupTextFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignupTextFields({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    super.key,
  });

  @override
  State<SignupTextFields> createState() => _SignupTextFieldsState();
}

class _SignupTextFieldsState extends State<SignupTextFields> {
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  static const Color _purpleGlow = Color(0xff8A5CFF);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField(controller: widget.nameController, hintText: 'الاسم الكامل', icon: Icons.person_outline_rounded),
        const SizedBox(height: 12),
        _buildField(controller: widget.emailController, hintText: 'البريد الإلكتروني', icon: Icons.mail_outline_rounded),
        const SizedBox(height: 12),
        _buildField(controller: widget.phoneController, hintText: 'رقم الهاتف', icon: Icons.phone_android_rounded, keyboardType: TextInputType.phone),
        const SizedBox(height: 12),
        _buildField(
          controller: widget.passwordController,
          hintText: 'كلمة المرور',
          icon: Icons.lock_outline_rounded,
          isObscured: _obscurePass,
          suffix: IconButton(
            icon: Icon(_obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white30, size: 16),
            onPressed: () => setState(() => _obscurePass = !_obscurePass),
          ),
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: widget.confirmPasswordController,
          hintText: 'تأكيد كلمة المرور',
          icon: Icons.lock_outline_rounded,
          isObscured: _obscureConfirm,
          suffix: IconButton(
            icon: Icon(_obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white30, size: 16),
            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isObscured = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _purpleGlow.withValues(alpha: 0.15)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscured,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 11, fontFamily: 'Cairo'),
          prefixIcon: Icon(icon, color: const Color(0xffA277FF), size: 16),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
