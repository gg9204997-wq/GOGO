import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String? image;

  final double radius;

  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    this.image,
    this.radius = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.card,
        backgroundImage:
            image != null && image!.isNotEmpty
                ? NetworkImage(image!)
                : null,
        child: image == null || image!.isEmpty
            ? Icon(
                Icons.person,
                size: radius,
                color: Colors.white70,
              )
            : null,
      ),
    );
  }
}