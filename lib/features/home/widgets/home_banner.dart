import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/home/models/banner_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  final List<BannerModel> banners;

  /// عند الضغط على أي بانر
  final void Function(BannerModel banner)? onBannerTap;

  const HomeBanner({
    super.key,
    this.banners = const [],
    this.onBannerTap,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<BannerModel> displayBanners =
        widget.banners.isNotEmpty
            ? widget.banners
            : [
                const BannerModel(
                  id: 'star_week',
                  title: 'نجم الأسبوع',
                  image: 'https://placeholder.com',
                  isActive: true,
                  sortOrder: 1,
                ),
              ];

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: displayBanners.length,
          options: CarouselOptions(
            height: 125,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            viewportFraction: 0.93,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = displayBanners[index];

            return GestureDetector(
              onTap: () {
                if (widget.onBannerTap != null) {
                  widget.onBannerTap!(banner);
                }
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff390B4B),
                      Color(0xff0F001D),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: const Color(0xff7A4DFF)
                        .withValues(alpha: 0.20),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Opacity(
                        opacity: .8,
                        child: Icon(
                          Icons.star_purple500_rounded,
                          color: const Color(0xffFFD700)
                              .withValues(alpha: .8),
                          size: 85,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Text(
                            banner.title,
                            style: const TextStyle(
                              color: Color(0xffFFD700),
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 3),

                          const Text(
                            'مبروك للفائز 💜 أسامة المصري',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 10),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient:
                                  const LinearGradient(
                                colors: [
                                  Color(0xff9E70FF),
                                  Color(0xff6C38FF),
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'عرض المزيد',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight:
                                    FontWeight.bold,
                                fontFamily: 'Cairo',
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

        const SizedBox(height: 6),

        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: displayBanners.length,
          effect: const ScrollingDotsEffect(
            activeDotColor: Colors.white,
            dotColor: Colors.white30,
            dotWidth: 5,
            dotHeight: 5,
          ),
        ),
      ],
    );
  }
}