extension StringExtensions on String {
  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;

  String get normalized => trim().replaceAll(RegExp(r'\s+'), ' ');

  String truncate(int maxLength) {
    if (length <= maxLength) {
      return this;
    }

    return substring(0, maxLength).trimRight();
  }
}
