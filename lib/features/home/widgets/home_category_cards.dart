import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class HomeCategoryCards extends StatelessWidget {
  const HomeCategoryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.card,
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.55,
        children: const [
          _CategoryCard(
            title: 'المشاهير',
            subtitle: 'Top Stars',
            icon: Icons.workspace_premium,
            color1: Color(0xff8E2DE2),
            color2: Color(0xff4A00E0),
          ),
          _CategoryCard(
            title: 'الوكالات',
            subtitle: 'Agencies',
            icon: Icons.apartment,
            color1: Color(0xff00B4DB),
            color2: Color(0xff0083B0),
          ),
          _CategoryCard(
            title: 'العائلات',
            subtitle: 'Families',
            icon: Icons.groups,
            color1: Color(0xffFF9966),
            color2: Color(0xffFF5E62),
          ),
          _CategoryCard(
            title: 'CV',
            subtitle: 'Profiles',
            icon: Icons.badge,
            color1: Color(0xff11998E),
            color2: Color(0xff38EF7D),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color1;
  final Color color2;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppRadius.radiusXxl,
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: AppRadius.radiusXxl,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color1,
              color2,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color2.withAlpha(90),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}