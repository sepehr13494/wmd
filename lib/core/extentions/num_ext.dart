import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NumExt on num {

  bool isNumeric(String s) {
    if(s.isEmpty) {
      return false;
    }

    return double.tryParse(s) != null ||
        int.tryParse(s) != null;
  }

  bool isBetween(num low, num high) => (this >= low && this < high);

  String convertMoney(
      {int digits = 0, bool addDollar = false, bool textDollar = false}) {
    String s = '';
    for (int i = 0; i < digits; i++) {
      s += "0";
    }
    return NumberFormat(
            "${addDollar ? (textDollar ? "USD " : "\$") : ""}#,##0${digits == 0 ? '' : '.$s'}",
            "en_US")
        .format(this);
  }

  String get formatNumber {
    String number = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol:
      '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(this);
    var split = number.split(".");
    if(split.length>1){
      if(split[1].length>1){
        if(split[1].length>1){
          var sub = split[1].substring(0,2);
          if(sub.length>1){
            if(isNumeric(sub[1])){
              number = number.replaceRange(split.first.length+2, split.first.length+3, "");
            }
          }

        }
      }
    }
    return number;
  }

  String formatNumberWithDecimal([int digits = 0]) {
    final val = NumberFormat.compactCurrency(
      decimalDigits: digits,
      symbol:
          '\$', // if you want to add currency symbol then pass that in this else leave it empty.
    );
    val.significantDigits = 2;
    return val.format(this);
  }
}
