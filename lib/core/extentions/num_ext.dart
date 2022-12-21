import 'package:intl/intl.dart';

extension NumExt on num {
  bool isBetween(num low, num high) => (this >= low && this < high);

  String convertMoney(
      {int digits = 0, bool addDollar = false, bool textDollar = false}) {
    String s = '';
    for (int i = 0; i < digits; i++) {
      s += "0";
    }
    return NumberFormat(
            "${addDollar ? (textDollar ? "USD" : "\$") : ""}#,##0${digits == 0 ? '' : '.$s'}",
            "en_US")
        .format(this);
  }

  String get formatNumber {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol:
          '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(this);
  }

  String formatNumberWithDecimal([int digits = 0]) {
    return NumberFormat.compactCurrency(
      decimalDigits: digits,
      symbol:
          '\$', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(this);
  }
}
