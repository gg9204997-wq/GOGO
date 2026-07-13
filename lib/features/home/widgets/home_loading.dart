import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';

class HomeLoading extends StatefulWidget {
  const HomeLoading({super.key});

  @override
  State<HomeLoading> createState() => _HomeLoadingState();
}

class _HomeLoadingState extends State<HomeLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget box({
    required double height,
    double? width,
    BorderRadius? radius,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Color.lerp(
              AppColors.surface,
              AppColors.card,
              _controller.value,
            ),
            borderRadius: radius ?? AppRadius.radiusLg,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: .72,
      ),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.radiusXxl,
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: box(
                  height: double.infinity,
                  radius: AppRadius.radiusLg,
                ),
              ),

              const SizedBox(height: 12),

              box(height: 16, width: 120),

              const SizedBox(height: 8),

              box(height: 12, width: 90),

              const Spacer(),

              Row(
                children: [
                  box(
                    height: 36,
                    width: 36,
                    radius: BorderRadius.circular(50),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: box(height: 14),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}