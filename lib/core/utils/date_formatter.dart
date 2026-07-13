import 'package:intl/intl.dart';

abstract final class DateFormatter {
  const DateFormatter._();

  static String time(DateTime value) {
    return DateFormat.Hm().format(value);
  }

  static String dayMonth(DateTime value) {
    return DateFormat.MMMd().format(value);
  }

  static String fullDate(DateTime value) {
    return DateFormat.yMMMd().format(value);
  }
}
