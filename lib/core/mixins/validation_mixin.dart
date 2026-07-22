mixin ValidationMixin {
  bool isValidEmail(String email) {
    return RegExp(
      r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  bool isStrongPassword(String password) {
    return password.length >= 6;
  }

  bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }
}