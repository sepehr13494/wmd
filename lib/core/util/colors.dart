import 'package:flutter/material.dart';

class AppColors{
  AppColors._();
  static const Color primaryLighter = Color(0xffB99855);
  static const Color primaryDarker = Color(0xffB99855);
  static const Color primary = Color(0xffB99855);
  static const Color accentLighter = Color(0xFFB99855);
  static const Color accent = Color(0xFFB99855);

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}