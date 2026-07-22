extension StringExtension on String {
  bool get isEmail {
    return RegExp(
      r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(trim());
  }

  bool get isPhone {
    return RegExp(r'^[0-9]{8,15}$')
        .hasMatch(trim());
  }

  bool get isNotBlank => trim().isNotEmpty;

  String get capitalize {
    if (isEmpty) return this;

    return this[0].toUpperCase() +
        substring(1);
  }

  String get removeSpaces =>
      replaceAll(' ', '');

  String get initials {
    final words = trim().split(' ');

    if (words.length == 1) {
      return words.first[0].toUpperCase();
    }

    return '${words.first[0]}${words.last[0]}'
        .toUpperCase();
  }
}