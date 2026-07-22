import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:joojo_chat/core/router/app_routes.dart';

class AuthGuard {
  AuthGuard._();

  static String? redirect(String location) {
    final user = Supabase.instance.client.auth.currentUser;

    final loggedIn = user != null;

    final isAuthPage = location == AppRoutes.login ||
        location == AppRoutes.register ||
        location == AppRoutes.forgotPassword ||
        location == AppRoutes.resetPassword;

    // المستخدم غير مسجل
    if (!loggedIn) {
      if (isAuthPage) {
        return null;
      }

      return AppRoutes.login;
    }

    // المستخدم مسجل بالفعل
    if (isAuthPage || location == AppRoutes.splash) {
      return AppRoutes.home;
    }

    return null;
  }
}