import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
}

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    required this.selectedGender,
    required this.onChanged,
    super.key,
  });

  final Gender? selectedGender;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderCard(
            title: 'ذكر',
            icon: Icons.male,
            selected: selectedGender == Gender.male,
            onTap: () => onChanged(Gender.male),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _GenderCard(
            title: 'أنثى',
            icon: Icons.female,
            selected: selectedGender == Gender.female,
            onTap: () => onChanged(Gender.female),
          ),
        ),
      ],
    );
  }
}

class _GenderCard extends StatelessWidget {
  const _GenderCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF7B2EFF)
              : const Color(0xFF1B1C2E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFF7B2EFF)
                : Colors.white12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}