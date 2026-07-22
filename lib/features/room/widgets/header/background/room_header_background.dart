import 'dart:ui';

import 'package:flutter/material.dart';

class RoomHeaderBackground extends StatelessWidget {
  const RoomHeaderBackground({
    super.key,
  });

  static const _radius = BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _radius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // الخلفية الأساسية
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff8A5BFF),
                  Color(0xff7146F8),
                  Color(0xff4D2FC0),
                  Color(0xff23144E),
                ],
                stops: [
                  0,
                  .35,
                  .72,
                  1,
                ],
              ),
            ),
          ),

          // هالة بنفسجية يسار
          Positioned(
            left: -90,
            top: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffB388FF)
                    .withValues(alpha: .18),
              ),
            ),
          ),

          // هالة ذهبية يمين
          Positioned(
            right: -70,
            top: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffFFD54F)
                    .withValues(alpha: .10),
              ),
            ),
          ),

          // ضباب خفيف
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 18,
              sigmaY: 18,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),

          // طبقة شفافة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: .06),
                  Colors.transparent,
                  Colors.black.withValues(alpha: .18),
                ],
              ),
            ),
          ),

          // لمعان علوي
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: .14),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ظل سفلي
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: .22),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}