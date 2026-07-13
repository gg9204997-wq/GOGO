import 'dart:async';

import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  late final PageController _controller;
  Timer? _timer;

  int _currentPage = 0;

  final List<_BannerItem> _items = const [
    _BannerItem(
      image: 'assets/banners/banner1.jpg',
      title: 'أفضل غرف الدردشة',
      subtitle: 'انضم إلى آلاف المستخدمين حول العالم',
    ),
    _BannerItem(
      image: 'assets/banners/banner2.jpg',
      title: 'فعاليات أسبوعية',
      subtitle: 'جوائز ومنافسات كل يوم',
    ),
    _BannerItem(
      image: 'assets/banners/banner3.jpg',
      title: 'غرف PK',
      subtitle: 'تحديات مباشرة مع الجميع',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = PageController();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        if (!_controller.hasClients) return;

        _currentPage++;

        if (_currentPage >= _items.length) {
          _currentPage = 0;
        }

        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: _controller,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (_, index) {
              final banner = _items[index];

              return Padding(
                padding: AppSpacing.card,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.radiusXxl,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(70),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        banner.image,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Colors.black.withAlpha(170),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.end,
                          children: [
                            Text(
                              banner.title,
                              style: AppTextStyles.headlineMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              banner.subtitle,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white70,
                              ),
                            ),

                            const SizedBox(height: 18),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius:
                                    AppRadius.radiusPill,
                              ),
                              child: Text(
                                'استكشف الآن',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _items.length,
            (index) {
              final active = index == _currentPage;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin:
                    const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.primary
                      : Colors.white24,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BannerItem {
  final String image;
  final String title;
  final String subtitle;

  const _BannerItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}