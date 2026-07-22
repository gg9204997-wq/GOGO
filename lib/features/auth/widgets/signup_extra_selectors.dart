// Path: lib/features/auth/widgets/signup_extra_selectors.dart

import 'package:flutter/material.dart';

class SignupExtraSelectors extends StatefulWidget {
  // 🌟 تم تصحيح نوع الراجع هنا صراحة بـ void وتسمية المتغير لحل تحذير الـ Lints القياسي بالملي
  final void Function(String gender) onGenderChanged;
  final VoidCallback onDateTap;
  final VoidCallback onCountryTap;
  final String selectedDateText;
  final String selectedCountryText;

  const SignupExtraSelectors({
    required this.onGenderChanged,
    required this.onDateTap,
    required this.onCountryTap,
    required this.selectedDateText,
    required this.selectedCountryText,
    super.key,
  });

  @override
  State<SignupExtraSelectors> createState() => _SignupExtraSelectorsState();
}

class _SignupExtraSelectorsState extends State<SignupExtraSelectors> {
  String _selectedGender = 'ذكر';
  static const Color _purpleGlow = Color(0xff8A5CFF);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // أزرار كبسولات تحديد الجنس (ذكر / أنثى) المتطابقة تماماً مع الصورة
        Row(
          children: [
            _buildGenderButton('ذكر', Icons.male_rounded, const Color(0xff00BFFF)),
            const SizedBox(width: 12),
            _buildGenderButton('أنثى', Icons.female_rounded, const Color(0xffFF1493)),
          ],
        ),
        const SizedBox(height: 12),

        // كبسولة اختيار تاريخ الميلاد
        _buildSelectorTile(
          text: widget.selectedDateText.isEmpty ? 'تاريخ الميلاد' : widget.selectedDateText,
          icon: Icons.calendar_month_outlined,
          onTap: widget.onDateTap,
        ),
        const SizedBox(height: 12),

        // كبسولة اختيار الدولة المفتوحة
        _buildSelectorTile(
          text: widget.selectedCountryText.isEmpty ? 'الدولة' : widget.selectedCountryText,
          icon: Icons.public_rounded,
          onTap: widget.onCountryTap,
        ),
      ],
    );
  }

  Widget _buildGenderButton(String gender, IconData icon, Color activeColor) {
    final bool isSelected = _selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedGender = gender);
          widget.onGenderChanged(gender);
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xff120D1F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? activeColor : _purpleGlow.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? activeColor : Colors.white30, size: 16),
              const SizedBox(width: 6),
              Text(
                gender, 
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white54, 
                  fontSize: 11, 
                  fontFamily: 'Cairo', 
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorTile({required String text, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xff120D1F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _purpleGlow.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xffA277FF), size: 16),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(color: Colors.white54, fontSize: 11, fontFamily: 'Cairo')),
            const Spacer(),
            const Icon(Icons.arrow_drop_down_rounded, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
