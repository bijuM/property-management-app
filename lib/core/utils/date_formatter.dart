import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String format(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatShort(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static String formatMonthShort(DateTime date) {
    return DateFormat('MMM yyyy').format(date);
  }

  static String formatDay(DateTime date) {
    return DateFormat('dd').format(date);
  }

  static String formatMonth(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  static String formatYear(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  static DateTime endOfYear(DateTime date) {
    return DateTime(date.year, 12, 31);
  }
}
