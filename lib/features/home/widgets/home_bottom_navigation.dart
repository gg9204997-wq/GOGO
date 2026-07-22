import 'package:flutter/material.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const HomeBottomNavigation({
    required this.currentIndex,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // ارتفاع متزن ليعطي مساحة للبروز الدائري والوهج السفلي بالملي
      color: Colors.transparent, // جعل الخلفية شفافة لكي يظهر انحناء الكبسولة الفخم
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // 1. الكبسولة الحاضنة للأزرار بالخلفية الزجاجية الداكنة والانحناءات الانسيابية
          Positioned(
            bottom: 12, // رفع الشريط قليلاً عن حافة الشاشة السفلية ليطابق الصورة
            left: 16,
            right: 16,
            child: Container(
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xff0D0B18).withValues(alpha: 0.92), // اللون الأرجواني الأسود الفخم جداً بالصورة
                borderRadius: BorderRadius.circular(30), // زوايا دائرية كاملة كالكبسولة بالملي
                border: Border.all(
                  color: const Color(0xff7A4DFF).withValues(alpha: 0.25), // خط نيون نحيف يحدد الحواف
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff7A4DFF).withValues(alpha: 0.15), // وهج خفيف محيط بالكبسولة كاملة
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // زر الرئيسية (مضاء بالأرجواني عند الاختيار)
                  _buildNavItem(
                    index: 0,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: 'الرئيسية',
                    hasGlow: true, // تفعيل الوهج السفلي المخصص للزر النشط بالصورة
                  ),
                  // زر استكشف
                  _buildNavItem(
                    index: 1,
                    icon: Icons.explore_outlined,
                    activeIcon: Icons.explore_rounded,
                    label: 'استكشف',
                    hasGlow: false,
                  ),

                  // تجويف برمجى فارغ في المنتصف ليتنفس فيه زر المايك الغائر
                  const SizedBox(width: 60),

                  // زر المتجر
                  _buildNavItem(
                    index: 2,
                    icon: Icons.local_mall_outlined,
                    activeIcon: Icons.local_mall_rounded,
                    label: 'المتجر',
                    hasGlow: false,
                  ),
                  // زر ملفي
                  _buildNavItem(
                    index: 3,
                    icon: Icons.person_outline_rounded,
                    activeIcon: Icons.person_rounded,
                    label: 'ملفي',
                    hasGlow: false,
                  ),
                ],
              ),
            ),
          ),

          // 2. زر المايك الدائري المتوهج والغائر في تجويف المنتصف بالملي طبق الأصل
          Positioned(
            bottom: 22, // خفضه قليلاً ليستقر داخل تجويف الكبسولة بشكل انسيابي فخم
            child: GestureDetector(
              onTap: () => onChanged(4), // التبويب المخصص للغرف الصوتية
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // التدرج النيوني البنفسجي المشع من وسط الزر بالصورة
                  gradient: const LinearGradient(
                    colors: [Color(0xff9E5CFF), Color(0xff5214CC)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: const Color(0xff0D0B18), // حافة داكنة تفصل الزر عن الوهج الخارجي
                    width: 3.5,
                  ),
                  boxShadow: [
                    // الوهج الأرجواني المتسع والمشع حول زر المايك بالملي
                    BoxShadow(
                      color: const Color(0xff8A5CFF).withValues(alpha: 0.65),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mic_none_rounded, // أيقونة ميكروفون مفرغة ونحيفة نيون بيضاء كالصورة تماماً
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool hasGlow,
  }) {
    final bool isActive = currentIndex == index;
    // عند تفعيل الزر النشط، يأخذ اللون البنفسجي المشرق، والخامل يأخذ اللون الرمادي الفضي بالصورة
    final Color itemColor = isActive ? const Color(0xffD4BFFF) : const Color(0xff74738B);

    return GestureDetector(
      onTap: () => onChanged(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // الوهج الأرجواني الصاعد من الأسفل والمحيط بالزر النشط (الرئيسية) بالصورة
            if (isActive && hasGlow)
              Positioned(
                bottom: -2,
                child: Container(
                  width: 34,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffA277FF).withValues(alpha: 0.45),
                        blurRadius: 10,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),

            // الأيقونة والنص المنسقين بالملي
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  color: itemColor,
                  size: 22,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    color: itemColor,
                    fontSize: 10,
                    fontFamily: 'Cairo', // الالتزام التام بخط القاهرة المعتمد بمشروعك
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
