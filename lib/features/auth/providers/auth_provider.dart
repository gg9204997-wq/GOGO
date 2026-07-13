import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';
import '../models/user_model.dart';

/// الحالة الحالية للمستخدم
final currentUserProvider = Provider<UserModel?>(
  (ref) {
    return ref.watch(authControllerProvider).valueOrNull;
  },
);

/// هل المستخدم مسجل دخول؟
final isLoggedInProvider = Provider<bool>(
  (ref) {
    final user = ref.watch(currentUserProvider);
    return user != null;
  },
);

/// اسم المستخدم
final usernameProvider = Provider<String>(
  (ref) {
    return ref.watch(currentUserProvider)?.username ?? '';
  },
);

/// الاسم الكامل
final fullNameProvider = Provider<String>(
  (ref) {
    return ref.watch(currentUserProvider)?.fullName ?? '';
  },
);

/// البريد الإلكتروني
final emailProvider = Provider<String>(
  (ref) {
    return ref.watch(currentUserProvider)?.email ?? '';
  },
);

/// رابط الصورة
final avatarProvider = Provider<String?>(
  (ref) {
    return ref.watch(currentUserProvider)?.avatarUrl;
  },
);

/// المستوى
final levelProvider = Provider<int>(
  (ref) {
    return ref.watch(currentUserProvider)?.level ?? 1;
  },
);

/// VIP
final vipLevelProvider = Provider<int>(
  (ref) {
    return ref.watch(currentUserProvider)?.vipLevel ?? 0;
  },
);

/// الرصيد (Coins)
final coinsProvider = Provider<int>(
  (ref) {
    return ref.watch(currentUserProvider)?.coins ?? 0;
  },
);

/// الرصيد (Diamonds)
final diamondsProvider = Provider<int>(
  (ref) {
    return ref.watch(currentUserProvider)?.diamonds ?? 0;
  },
);

/// الحالة
final onlineStatusProvider = Provider<bool>(
  (ref) {
    return ref.watch(currentUserProvider)?.online ?? false;
  },
);

/// اللغة
final languageProvider = Provider<String>(
  (ref) {
    return ref.watch(currentUserProvider)?.language ?? 'ar';
  },
);

/// الدور
final roleProvider = Provider<String>(
  (ref) {
    return ref.watch(currentUserProvider)?.role ?? 'user';
  },
);

/// هل الحساب موثق؟
final verifiedProvider = Provider<bool>(
  (ref) {
    return ref.watch(currentUserProvider)?.verified ?? false;
  },
);

/// عدد المتابعين
final followersProvider = Provider<int>(
  (ref) {
    return ref.watch(currentUserProvider)?.followers ?? 0;
  },
);

/// عدد المتابَعين
final followingProvider = Provider<int>(
  (ref) {
    return ref.watch(currentUserProvider)?.following ?? 0;
  },
);

/// عدد الزوار
final visitorsProvider = Provider<int>(
  (ref) {
    return ref.watch(currentUserProvider)?.visitors ?? 0;
  },
);