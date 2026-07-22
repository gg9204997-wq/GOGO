import 'app_exception.dart';

class AuthException extends AppException {
  const AuthException(super.message);

  factory AuthException.fromCode(String code) {
    switch (code) {
      case 'invalid_credentials':
        return const AuthException(
          'البريد الإلكتروني أو كلمة المرور غير صحيحة',
        );

      case 'email_exists':
        return const AuthException(
          'البريد الإلكتروني مستخدم بالفعل',
        );

      case 'email_not_confirmed':
        return const AuthException(
          'يرجى تأكيد البريد الإلكتروني',
        );

      case 'weak_password':
        return const AuthException(
          'كلمة المرور ضعيفة',
        );

      default:
        return const AuthException(
          'حدث خطأ غير متوقع',
        );
    }
  }
}