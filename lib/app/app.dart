import 'package:flutter/material.dart';

import 'package:joojo_chat/app/app_router.dart';
import 'package:joojo_chat/core/constants/app_constants.dart';
import 'package:joojo_chat/core/theme/app_theme.dart';

class JoojoChatApp extends StatelessWidget {
  const JoojoChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter.router,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
