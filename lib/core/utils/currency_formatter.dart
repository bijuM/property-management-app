import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static const String qatariRiyal = 'QAR';
  static const String symbol = 'ر.ق';

  static String format(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'ar_QA',
      symbol: symbol,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static String formatCompact(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M $symbol';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K $symbol';
    }
    return '$symbol${amount.toStringAsFixed(0)}';
  }

  static String simpleFormat(double amount) {
    return '$symbol ${amount.toStringAsFixed(0)}';
  }
}
