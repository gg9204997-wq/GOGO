import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:joojo_chat/app/app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = FlutterError.presentError;

  await runZonedGuarded(
    () async {
      await Supabase.initialize(
        url: 'YOUR_SUPABASE_URL',
        publishableKey: 'YOUR_SUPABASE_PUBLISHABLE_KEY',
      );

      runApp(
        const ProviderScope(
          child: JoojoApp(),
        ),
      );
    },
    (error, stackTrace) {
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    },
  );
}