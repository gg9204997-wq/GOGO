extension DateTimeExtension on DateTime {
  bool get isToday {
    final now = DateTime.now();

    return year == now.year &&
        month == now.month &&
        day == now.day;
  }

  bool get isYesterday {
    final yesterday =
        DateTime.now().subtract(
      const Duration(days: 1),
    );

    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  String get hhmm {
    final h =
        hour.toString().padLeft(2, '0');

    final m =
        minute.toString().padLeft(2, '0');

    return '$h:$m';
  }
}