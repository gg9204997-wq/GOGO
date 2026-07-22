// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/app_routes.dart';
import 'package:joojo_chat/core/router/navigation_shell.dart';
import 'package:joojo_chat/features/auth/pages/complete_profile_screen.dart';
import 'package:joojo_chat/features/auth/pages/login_screen.dart';
import 'package:joojo_chat/features/auth/pages/otp_verification_screen.dart';
import 'package:joojo_chat/features/auth/pages/phone_login_screen.dart';
import 'package:joojo_chat/features/auth/pages/reset_password_screen.dart';
import 'package:joojo_chat/features/auth/pages/signup_screen.dart';
import 'package:joojo_chat/features/auth/pages/welcome_splash_screen.dart';
import 'package:joojo_chat/features/explore/pages/explore_page.dart';
import 'package:joojo_chat/features/home/pages/home_page.dart';
import 'package:joojo_chat/features/profile/pages/profile_page.dart';
import 'package:joojo_chat/features/room/create_room_page.dart';
import 'package:joojo_chat/features/room/room_page.dart';
import 'package:joojo_chat/features/shop/pages/shop_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.launch,
  routes: [
    GoRoute(
      path: AppRoutes.launch,
      builder: (context, state) => const WelcomeSplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.phoneLogin,
      builder: (context, state) => const PhoneLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.completeProfile,
      builder: (context, state) => const CompleteProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: '/rooms/create',
      builder: (context, state) {
        final userId = state.uri.queryParameters['userId'] ?? 'current_user_id';
        return CreateRoomPage(userId: userId);
      },
    ),
    GoRoute(
      path: '/rooms/:roomId',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId']!;
        return RoomPage(roomId: roomId); 
      },
    ),
    // ⚙️ دمج الـ StatefulShellRoute وتغذية الـ NavigationShell القديم عبر بارامتر الـ child لحل الأخطاء فوراً
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state, navigationShell) {
        // تمرير الـ navigationShell داخل الـ child لإصلاح خطأ missing_required_argument وسوء الفهم البرمجي بالكامل
        return NavigationShell(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.explore,
              builder: (context, state) => const ExplorePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.shop,
              builder: (context, state) => const ShopPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
