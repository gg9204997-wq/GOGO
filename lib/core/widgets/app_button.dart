import 'package:flutter/material.dart';

import 'package:joojo_chat/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width = double.infinity,
    this.height = 56,
    this.loading = false,
    this.enabled = true,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 16,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  final double width;
  final double height;

  final bool loading;
  final bool enabled;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final bool canPress = enabled && !loading;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: canPress ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          disabledBackgroundColor: AppColors.divider,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}