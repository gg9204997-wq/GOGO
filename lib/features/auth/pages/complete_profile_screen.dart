// Path: lib/features/auth/pages/complete_profile_screen.dart

import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _bioController = TextEditingController();
  static const Color _purpleGlow = Color(0xff8A5CFF);
  // 🌟 تم حذف المتغير غير المستخدم _goldColor لحل تحذير unused_field بالملي

  String _selectedCountry = 'مصر 🇪🇬';
  String _selectedCity = 'القاهرة';

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090514),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // 🌟 تم حذف حقل crossAxisAlignment الزائد لحل تحذير avoid_redundant_argument_values بالملي
            children: [
              const Text(
                'أكمل ملفك الشخصي',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
              ),
              const SizedBox(height: 4),
              Text(
                'لتفعيل حسابك بشكل كامل داخل الغرف',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 11, fontFamily: 'Cairo'),
              ),
              const SizedBox(height: 24),

              // حلقة الكاميرا المضيئة لرفع الصورة الشخصية الفورية
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff120D1F),
                      border: Border.all(color: _purpleGlow.withValues(alpha: 0.35), width: 1.5),
                    ),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // حقل كتابة النبذة التعبيرية (Bio)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff120D1F),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _purpleGlow.withValues(alpha: 0.15)),
                ),
                child: TextFormField(
                  controller: _bioController,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white, fontSize: 12.5),
                  decoration: const InputDecoration(
                    hintText: 'اكتب نبذة تعريفية عنك...',
                    hintStyle: TextStyle(color: Colors.white24, fontSize: 11, fontFamily: 'Cairo'),
                    prefixIcon: Icon(Icons.mode_comment_outlined, color: _purpleGlow, size: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // اختيار الدولة
              _buildSelectorTile(
                text: _selectedCountry,
                icon: Icons.public_rounded,
                onTap: () => setState(() => _selectedCountry = 'السعودية 🇸🇦'),
              ),
              const SizedBox(height: 12),

              // اختيار المدينة
              _buildSelectorTile(
                text: _selectedCity,
                icon: Icons.location_city_rounded,
                onTap: () => setState(() => _selectedCity = 'الرياض'),
              ),
              const SizedBox(height: 35),

              // زر حفظ ومتابعة العريض بالأرجواني النيوني
              GestureDetector(
                onTap: () {
                  // ميكانيزم الحفظ والانتقال للرئيسية
                },
                child: Container(
                  width: double.infinity,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xff8A5CFF), Color(0xff5214CC)]),
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: [
                      BoxShadow(color: _purpleGlow.withValues(alpha: 0.25), blurRadius: 12),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'حفظ ومتابعة',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectorTile({required String text, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xff120D1F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _purpleGlow.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xffA277FF), size: 16),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'Cairo')),
            const Spacer(),
            const Icon(Icons.arrow_drop_down_rounded, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
