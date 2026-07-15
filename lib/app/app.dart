import 'package:flutter/material.dart';

import 'package:joojo_chat/app/app_config.dart';
import 'package:joojo_chat/core/router/router.dart';
import 'package:joojo_chat/core/theme/app_theme.dart';

class JoojoApp extends StatelessWidget {
  const JoojoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: AppConfig.appName,

      theme: AppTheme.dark,

      routerConfig: AppRouter.router,
    );
  }
}