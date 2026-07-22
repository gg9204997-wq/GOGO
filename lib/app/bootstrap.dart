// Path: lib/app/bootstrap.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:joojo_chat/app/app.dart';

Future<void> bootstrap() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = FlutterError.presentError;

    // تفعيل الربط الحقيقي والنهائي بقاعدة بيانات جوجو شات
    await Supabase.initialize(
      url: 'https://gtiluylrdlfestfnlmzs.supabase.co',
      publishableKey: 'sb_publishable_lyZtCv0kZxLZ49phpwlUjQ_p81otaUt',
    );

    runApp(
      const ProviderScope(
        // 🌟 تم تصحيح اسم الكلاس هنا لـ App() ليتطابق بالملي مع ملف الـ app.dart وتختفي الخطوط الحمراء فوراً
        child: App(),
      ),
    );
  }, (error, stack) {
    debugPrint(error.toString());
    debugPrint(stack.toString());
  });
}
