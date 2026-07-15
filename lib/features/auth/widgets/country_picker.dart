import 'package:flutter/material.dart';

class CountryPicker extends StatelessWidget {
  const CountryPicker({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String? value;
  final ValueChanged<String?> onChanged;

  static const List<String> countries = [
    '🇪🇬 مصر',
    '🇸🇦 السعودية',
    '🇦🇪 الإمارات',
    '🇰🇼 الكويت',
    '🇶🇦 قطر',
    '🇧🇭 البحرين',
    '🇴🇲 عمان',
    '🇮🇶 العراق',
    '🇯🇴 الأردن',
    '🇱🇧 لبنان',
    '🇸🇾 سوريا',
    '🇵🇸 فلسطين',
    '🇱🇾 ليبيا',
    '🇩🇿 الجزائر',
    '🇲🇦 المغرب',
    '🇹🇳 تونس',
    '🇸🇩 السودان',
    '🇾🇪 اليمن',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: const Color(0xFF1B1C2E),
      decoration: InputDecoration(
        hintText: 'اختر الدولة',
        hintStyle: const TextStyle(
          color: Colors.white54,
        ),
        prefixIcon: const Icon(
          Icons.public,
          color: Color(0xFF7B2EFF),
        ),
        filled: true,
        fillColor: const Color(0xFF1B1C2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      items: countries
          .map(
            (country) => DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}