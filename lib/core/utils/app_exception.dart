final class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.cause,
  });

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() {
    if (code == null) {
      return message;
    }

    return '$code: $message';
  }
}
