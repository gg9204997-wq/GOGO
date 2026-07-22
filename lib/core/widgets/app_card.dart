// Path: lib/core/widgets/app_card.dart

import 'package:flutter/material.dart';
// 💡 تم تحويل الـ Imports النسبية إلى Package Imports كاملة لحل تنبيهات الأسطر 3 و 4 و 5
import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_shadows.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  // 💡 تم تقديم المعامل الإجباري required child في البداية تماماً قبل الـ super.key لحل تنبيه السطر 16
  const AppCard({
    required this.child,
    super.key,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.card,
          ),
          child: child,
        ),
      ),
    );
  }
}
