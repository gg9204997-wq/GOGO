import 'package:flutter/material.dart';

class RoomHeaderBorder extends StatelessWidget {
  const RoomHeaderBorder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: .10),
            width: 1,
          ),
          boxShadow: [
            // ظل خارجي
            BoxShadow(
              color: Colors.black.withValues(alpha: .25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),

            // هالة بنفسجية
            BoxShadow(
              color: const Color(0xff8D5CFF)
                  .withValues(alpha: .10),
              blurRadius: 35,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // لمعان الحافة العلوية
            Positioned(
              top: 0,
              left: 20,
              right: 20,
              child: Container(
                height: 1.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: .55),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // لمعان يسار
            Positioned(
              left: 0,
              top: 18,
              bottom: 25,
              child: Container(
                width: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: .20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // لمعان يمين
            Positioned(
              right: 0,
              top: 18,
              bottom: 25,
              child: Container(
                width: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: .20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // خط ذهبي أسفل الهيدر
            Positioned(
              left: 35,
              right: 35,
              bottom: 0,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Color(0xffFFD54F),
                      Color(0xffFFF3B0),
                      Color(0xffFFD54F),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}