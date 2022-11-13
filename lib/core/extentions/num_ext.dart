import 'package:intl/intl.dart';

extension NumExt on num {
  bool isBetween(num low, num high) => (this >= low && this < high);

  String convertMoney({int digits = 0}) {
    String s = '';
    for (int i = 0; i < digits; i++) {
      s += "0";
    }
    return NumberFormat("#,##0${digits == 0 ? '' : '.$s'}", "en_US")
        .format(this);
  }
}

extension DoubleExt on double {
  String toMoney() => NumberFormat("#,##0.00", "en_US").format(this);
}
