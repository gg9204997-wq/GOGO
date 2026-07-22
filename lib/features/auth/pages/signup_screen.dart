// Path: lib/features/auth/pages/signup_screen.dart

import 'dart:io'; 
import 'package:cached_network_image/cached_network_image.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:joojo_chat/core/router/app_routes.dart';
import 'package:joojo_chat/features/agency/providers/auth_provider.dart';
import 'package:joojo_chat/features/auth/widgets/signup_avatar_picker.dart';
import 'package:joojo_chat/features/auth/widgets/signup_extra_selectors.dart';
import 'package:joojo_chat/features/auth/widgets/signup_text_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedGender = 'ذكر';
  String _selectedDateText = '';
  String _selectedCountryText = '';
  
  File? _pickedAvatarFile; 
  final ImagePicker _picker = ImagePicker();

  // حقول استقبال روابط الخلفية والشعار كصور من لوحة التحكم بالسيرفر حياً بالملي
  String? _serverBackgroundUrl;
  String? _serverLogoUrl;

  @override
  void initState() {
    super.initState();
    _fetchAdminAssetsFromServer();
  }

  /// 🌐 دالة جلب رابط الخلفية والشعار الذين يتحكم بهما المدير من السيرفر حياً
  Future<void> _fetchAdminAssetsFromServer() async {
    try {
      final supabase = Supabase.instance.client;
      final data = await supabase.from('app_settings').select('splash_image_url, app_logo_url').maybeSingle();

      if (data != null) {
        if (mounted) {
          setState(() {
            _serverBackgroundUrl = data['splash_image_url']?.toString();
            _serverLogoUrl = data['app_logo_url']?.toString();
          });
        }
      }
    } catch (_) {
      // حماية المنصة في حال ضعف الشبكة
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  /// 📸 1. ميكانيزم قراءة وفتح معرض الصور والكاميرا الحقيقي 100% بالجهاز
  Future<void> _pickAvatarImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70, // ضغط جودة الصورة لـ 70% للحفاظ على سرعة الرفع والسيرفر
        maxWidth: 400,   // أقصى عرض للصورة لتوحيد المقاسات القياسية بالمنصة
      );
      
      if (pickedFile != null) {
        setState(() {
          _pickedAvatarFile = File(pickedFile.path);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('🎉 تم اختيار صورة الملف الشخصي بنجاح!', style: TextStyle(fontFamily: 'Cairo'))),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ نعتذر، فشل الوصول للملفات. تأكد من منح الصلاحيات للتطبيق', style: TextStyle(fontFamily: 'Cairo'))),
        );
      }
    }
  }

  void _showAvatarSourcePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff120D1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'اختر صورة الملف الشخصي',
                  style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded, color: Color(0xffA277FF)),
                  title: const Text('التقاط صورة بالكاميرا 📸', style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 12.5)),
                  onTap: () {
                    Navigator.pop(context);
                    _pickAvatarImage(ImageSource.camera); // فتح الكاميرا الحية حقيقياً
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_rounded, color: Color(0xffA277FF)),
                  title: const Text('اختيار من معرض الصور 🖼️', style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 12.5)),
                  onTap: () {
                    Navigator.pop(context);
                    _pickAvatarImage(ImageSource.gallery); // فتح معرض الجوال حقيقياً
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 📅 2. ميكانيزم التقويم الحقيقي لفتح رزنامة فلاتر الرسمية واختيار المواليد بدقة
  Future<void> _openDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff8A5CFF),
              onPrimary: Colors.white,
              surface: Color(0xff120D1F),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDateText = '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  /// 🗺️ 3. ميكانيزم نافذة دول العالم الشاملة لعرض قائمة الدول مع الأعلام واختيارها لحظياً
  void _openCountryPicker() {
    final List<String> countriesList = [
      'المملكة العربية السعودية 🇸🇦',
      'جمهورية مصر العربية 🇪🇬',
      'الإمارات العربية المتحدة 🇦🇪',
      'الكويت 🇰🇼',
      'قطر 🇶🇦',
      'البحرين 🇧🇭',
      'سلطنة عمان 🇴🇲',
      'العراق 🇮🇶',
      'الأردن 🇯🇴',
      'المغرب 🇲🇦',
      'الجزائر 🇩🇿',
      'تونس 🇹🇳',
      'لبنان 🇱🇧',
      'الولايات المتحدة الأمريكية 🇺🇸',
      'المملكة المتحدة 🇬🇧',
      'فرنسا 🇫🇷',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff0D0B18),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 350,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'اختر الدولة',
                  style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: countriesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(countriesList[index], style: const TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 13)),
                      onTap: () {
                        setState(() {
                          _selectedCountryText = countriesList[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    const Color purpleGlow = Color(0xff8A5CFF);
    final authState = ref.watch(authProvider);

    // مراقبة استجابة السيرفر لعرض الأخطاء أو التوجيه التلقائي
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!, style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
            backgroundColor: Colors.red.withValues(alpha: 0.8),
          ),
        );
      }
      if (next.isSuccess && next.user != null) {
        context.go(AppRoutes.completeProfile);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      body: Stack(
        children: [
          // 1. 🌟 صورة الخلفية الكاملة المدارة والمرفوعة من قِبلك كمدير في السيرفر
          Positioned.fill(
            child: _serverBackgroundUrl != null && _serverBackgroundUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: _serverBackgroundUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => Container(color: const Color(0xff090514)),
                  )
                : Container(color: const Color(0xff090514)), // الخلفية الافتراضية للحماية
          ),

          // 2. طبقة تعتيم زجاجية انسيابية داكنة لضمان وضوح نصوص الإدخال الفخمة
          Positioned.fill(
            child: Container(
              color: const Color(0xff090514).withValues(alpha: 0.85),
            ),
          ),

          // 3. المحتوى التفاعلي الكلي للشاشة مصفى وبدون تحذيرات
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      
                      // 🌟 صورة الشعار (الـ Logo) المدارة والمرفوعة من قِبلك كمدير بالسيرفر كصورة حية
                      if (_serverLogoUrl != null && _serverLogoUrl!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: CachedNetworkImage(
                            imageUrl: _serverLogoUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const SizedBox(width: 80, height: 80),
                            errorWidget: (context, url, error) => const SizedBox(),
                          ),
                        ),

                      /// ويدجت حلقة رفع الصورة الشخصية (Avatar Picker) المفتوحة حياً
                      SignupAvatarPicker(
                        onPickTap: _showAvatarSourcePicker,
                      ),

                      const SizedBox(height: 22),

                      /// ويدجت الحقول النصية الأساسية للهوية
                      SignupTextFields(
                        nameController: _nameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),

                      const SizedBox(height: 15),

                      /// ويدجت الاختيارات الحية المربوطة بالتقويم والدول كلياً
                      SignupExtraSelectors(
                        selectedDateText: _selectedDateText,
                        selectedCountryText: _selectedCountryText,
                        onGenderChanged: (gender) {
                          setState(() {
                            _selectedGender = gender;
                          });
                        },
                        onDateTap: _openDatePicker,
                        onCountryTap: _openCountryPicker,
                      ),

                      const SizedBox(height: 30),

                      // زر إنشاء حساب الملكي المتفاعل حياً مع الـ Provider والسيرفر
                      GestureDetector(
                        onTap: authState.isLoading
                            ? null 
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController.text != _confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('كلمتا المرور غير متطابقتين!', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  
                                  // ربط كامل الحقول وتمريرها حياً للسيرفر دون نقصان بالملي
                                  ref.read(authProvider.notifier).signUpWithEmail(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text.trim(),
                                        name: _nameController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        gender: _selectedGender,
                                        birthday: _selectedDateText,
                                        country: _selectedCountryText,
                                      );
                                }
                              },
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff8A5CFF),
                                Color(0xff5214CC),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: purpleGlow.withValues(alpha: 0.30),
                                blurRadius: 14,
                              )
                            ],
                          ),
                          child: authState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'إنشاء حساب',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // سطر العودة وتفعيل الولوج لتسجيل الدخول بأسفل كبسولة الواجهة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لديك حساب بالفعل؟ ',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.45),
                              fontFamily: 'Cairo',
                              fontSize: 11,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.go(AppRoutes.login),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                color: Color(0xffA277FF),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
