import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppChip extends StatelessWidget {
  final String title;

  final bool selected;

  final VoidCallback? onTap;

  const AppChip({
    super.key,
    required this.title,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onTap,
      label: Text(title),
      backgroundColor:
          selected
              ? AppColors.primary
              : AppColors.card,
      labelStyle: TextStyle(
        color:
            selected
                ? Colors.white
                : AppColors.grey,
      ),
    );
  }
}