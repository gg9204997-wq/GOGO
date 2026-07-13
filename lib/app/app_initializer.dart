import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joojo_chat/core/constants/app_constants.dart';
import 'package:joojo_chat/core/services/app_logger_service.dart';
import 'package:joojo_chat/core/services/service_registry.dart';
import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class AppInitializer {
  const AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      AppLoggerService.error(
        details.exceptionAsString(),
        error: details.exception,
        stackTrace: details.stack,
      );
    };

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      publishableKey: AppConstants.supabaseAnonKey,
    );

    await ServiceRegistry.initialize();
  }
}
