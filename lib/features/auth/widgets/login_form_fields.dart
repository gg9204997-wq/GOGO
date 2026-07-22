// Path: lib/features/auth/widgets/login_form_fields.dart

import 'package:flutter/material.dart';

class LoginFormFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormFields({
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  bool _rememberMe = false;
  bool _isPasswordObscured = true;
  
  // 🌟 تم تصحيحها هنا برمجياً إلى static const لحل خطأ const_instance_field بالملي
  static const Color _purpleGlow = Color(0xff8A5CFF);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField(
          controller: widget.emailController,
          hintText: 'البريد الإلكتروني أو رقم الهاتف',
          icon: Icons.dynamic_feed_outlined,
        ),
        const SizedBox(height: 14),
        _buildField(
          controller: widget.passwordController,
          hintText: 'كلمة المرور',
          icon: Icons.lock_outline_rounded,
          isObscured: _isPasswordObscured,
          suffix: IconButton(
            icon: Icon(
              _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.white30,
              size: 18,
            ),
            onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    activeColor: _purpleGlow,
                    checkColor: Colors.white,
                    side: const BorderSide(color: Colors.white30),
                    onChanged: (val) => setState(() => _rememberMe = val ?? false),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('تذكرني', style: TextStyle(color: Colors.white60, fontSize: 11, fontFamily: 'Cairo')),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: const Text('نسيت كلمة المرور؟', style: TextStyle(color: Color(0xffA277FF), fontSize: 11, fontFamily: 'Cairo')),
            ),
          ],
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
        style: const TextStyle(color: Colors.white, fontSize: 12.5),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 11, fontFamily: 'Cairo'),
          prefixIcon: Icon(icon, color: const Color(0xffA277FF), size: 18),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        ),
      ),
    );
  }
}
