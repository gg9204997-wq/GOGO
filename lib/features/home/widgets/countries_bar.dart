import 'package:flutter/material.dart';
import 'package:joojo_chat/features/home/models/home_country_model.dart';

class CountriesBar extends StatefulWidget {
  final List<HomeCountryModel> countries;
  final Function(String countryCode) onCountrySelected;

  const CountriesBar({
    required this.onCountrySelected,
    this.countries = const [], // استلام قائمة الدول ديناميكياً من قاعدة البيانات
    super.key,
  });

  @override
  State<CountriesBar> createState() => _CountriesBarState();
}

class _CountriesBarState extends State<CountriesBar> {
  int selectedIndex = 0; // مصر هي التبويب المختار افتراضياً بالصورة

  @override
  Widget build(BuildContext context) {
    // 💡 قائمة الدول المكتملة بنفس أعلام وترتيب الصورة بالملي في حال عدم تحميل السيرفر مؤقتاً
    final List<HomeCountryModel> displayCountries = widget.countries.isNotEmpty
        ? widget.countries
        : [
            const HomeCountryModel(id: 'c1', name: 'مصر', countryCode: 'eg', flagUrl: '🇪🇬'),
            const HomeCountryModel(id: 'c2', name: 'السعودية', countryCode: 'sa', flagUrl: '🇸🇦'),
            const HomeCountryModel(id: 'c3', name: 'الإمارات', countryCode: 'ae', flagUrl: '🇦🇪'),
            const HomeCountryModel(id: 'c4', name: 'الكويت', countryCode: 'kw', flagUrl: '🇰🇼'),
            const HomeCountryModel(id: 'c5', name: 'العراق', countryCode: 'iq', flagUrl: '🇮🇶'),
            const HomeCountryModel(id: 'c6', name: 'الأردن', countryCode: 'jo', flagUrl: '🇯🇴'),
            const HomeCountryModel(id: 'c7', name: 'لبنان', countryCode: 'lb', flagUrl: '🇱🇧'),
            const HomeCountryModel(id: 'c8', name: 'المغرب', countryCode: 'ma', flagUrl: '🇲🇦'),
            const HomeCountryModel(id: 'c9', name: 'الجزائر', countryCode: 'dz', flagUrl: '🇩🇿'),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // عنوان القسم الفرعي والأيقونة الجانبية
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              Icon(Icons.language_rounded, color: Color(0xffA879FF), size: 16),
              SizedBox(width: 6),
              Text(
                'جميع الدول',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        
        // قائمة الأعلام الدائرية والأسماء المضاءة بالملي
        SizedBox(
          height: 66,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: displayCountries.length,
            itemBuilder: (context, index) {
              final country = displayCountries[index];
              final bool isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                  widget.onCountrySelected(country.countryCode); // تمرير الكود لتحديث الغرف الحية فوراً
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      // كرت العلم الدائري المتناسق بالملي
                      Container(
                        width: 42,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff151124),
                          border: Border.all(
                            color: isSelected ? const Color(0xffFFD700) : Colors.white.withValues(alpha: 0.08),
                            width: isSelected ? 1.5 : 1,
                          ),
                          boxShadow: isSelected
                              ? [BoxShadow(color: const Color(0xffFFD700).withValues(alpha: 0.25), blurRadius: 8)]
                              : null,
                        ),
                        child: Text(
                          country.flagUrl, // عرض علم الدولة النصي أو رابط الصورة لاحقاً
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // اسم الدولة الملون بالذهبي عند الاختيار
                      Text(
                        country.name,
                        style: TextStyle(
                          color: isSelected ? const Color(0xffFFD700) : const Color(0xffA0A5B5),
                          fontSize: 10,
                          fontFamily: 'Cairo',
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
