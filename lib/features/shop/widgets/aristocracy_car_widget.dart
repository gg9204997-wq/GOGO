import 'package:flutter/material.dart';

class AristocracyCarWidget extends StatefulWidget {
  final String carTitle;
  final VoidCallback onAnimationComplete;

  const AristocracyCarWidget({
    required this.carTitle,
    required this.onAnimationComplete,
    super.key,
  });

  @override
  State<AristocracyCarWidget> createState() => _AristocracyCarWidgetState();
}

class _AristocracyCarWidgetState extends State<AristocracyCarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // السيارة تأخذ 4 ثواني للمرور الفخم عبر الشاشة كاملة
    );

    // تحريك وتمرير السيارة أفقياً بالملي من خارج اليمين إلى خارج اليسار
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0.0), // البدء من خارج يمين الشاشة
      end: const Offset(-1.5, 0.0),  // الانتهاء خارج يسار الشاشة
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete(); // إخفاء الويدجت وتدميرها برمجياً فور انتهاء الحركة بنجاح
      }
    });

    _animationController.forward(); // بدء انطلاق موكب السيارة نيون فوراً بالملي
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // أيقونة السيارة النيون المشعة البرتقالية بالملي كالصورة
              const Icon(
                Icons.directions_car_filled_rounded,
                color: Color(0xffFF8C00),
                size: 36,
              ),
              const SizedBox(width: 8),
              Text(
                widget.carTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Color(0xffFF8C00), blurRadius: 10)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
