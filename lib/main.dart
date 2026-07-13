import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/app/app.dart';
import 'package:joojo_chat/app/app_initializer.dart';

Future<void> main() async {
  await AppInitializer.initialize();

  runApp(
    const ProviderScope(
      child: JoojoChatApp(),
    ),
  );
}
