import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDatePicker extends StatelessWidget {
  const BirthDatePicker({
    required this.birthDate,
    required this.onSelect,
    super.key,
  });

  final DateTime? birthDate;
  final ValueChanged<DateTime> onSelect;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1950),
      lastDate: now,
    );

    if (picked != null) {
      onSelect(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _pickDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: 'تاريخ الميلاد',
          prefixIcon: const Icon(
            Icons.cake,
            color: Color(0xFF7B2EFF),
          ),
          filled: true,
          fillColor: const Color(0xFF1B1C2E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        child: Text(
          birthDate == null
              ? 'اختر تاريخ الميلاد'
              : DateFormat('yyyy-MM-dd').format(birthDate!),
          style: TextStyle(
            color: birthDate == null
                ? Colors.white54
                : Colors.white,
          ),
        ),
      ),
    );
  }
}