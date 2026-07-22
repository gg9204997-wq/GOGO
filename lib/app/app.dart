import 'package:flutter/material.dart';
// 🌟 تم إضافة استدعاء ملف الـ AppRouter ليتعرف عليه الكومبايلر فوراً
import 'package:joojo_chat/core/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'JooJo Chat',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff090514),
        fontFamily: 'Cairo', // الالتزام التام بخط القاهرة المعتمد بمنصتك الملكية
      ),
      // 🌟 تم تصحيح الاسم هنا برمجياً إلى appRouter (بأحرف صغيرة) ليتطابق مع الـ GoRouter المطور بالملي
      routerConfig: appRouter, 
    );
  }
}
