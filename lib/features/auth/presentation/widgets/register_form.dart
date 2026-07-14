import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    required this.nameController, required this.emailController, required this.passwordController, required this.confirmPasswordController, required this.obscurePassword, required this.obscureConfirmPassword, required this.onTogglePassword, required this.onToggleConfirmPassword, required this.selectedCountry, required this.countries, required this.onCountryChanged, required this.birthDate, required this.onPickDate, required this.formatDate, required this.buildInput, super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final bool obscurePassword;
  final bool obscureConfirmPassword;

  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  final String? selectedCountry;
  final List<String> countries;

  final ValueChanged<String?> onCountryChanged;

  final DateTime? birthDate;

  final VoidCallback onPickDate;

  final String Function(DateTime?) formatDate;

  final Widget Function(
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool obscure,
    Widget? suffixIcon,
  }) buildInput;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInput(
          'الاسم الكامل',
          Icons.person_outline,
          nameController,
        ),

        const SizedBox(height: 15),

        buildInput(
          'البريد الإلكتروني',
          Icons.email_outlined,
          emailController,
        ),

        const SizedBox(height: 15),

        buildInput(
          'كلمة المرور',
          Icons.lock_outline,
          passwordController,
          obscure: obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey,
              size: 20,
            ),
            onPressed: onTogglePassword,
          ),
        ),

        const SizedBox(height: 15),

        buildInput(
          'تأكيد كلمة المرور',
          Icons.lock_reset_outlined,
          confirmPasswordController,
          obscure: obscureConfirmPassword,
          suffixIcon: IconButton(
            icon: Icon(
              obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey,
              size: 20,
            ),
            onPressed: onToggleConfirmPassword,
          ),
        ),

        const SizedBox(height: 15),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1B0E3D),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: const Color(0xFF140933),
              value: selectedCountry,
              hint: const Text(
                'اختر الدولة',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.purpleAccent,
              ),
              items: countries
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(
                        c,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onCountryChanged,
            ),
          ),
        ),

        const SizedBox(height: 15),

        GestureDetector(
          onTap: onPickDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1B0E3D),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDate(birthDate),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.purpleAccent,
                  size: 18,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}