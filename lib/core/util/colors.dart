import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primaryLighter = Color(0xffB99855);
  static const Color primaryDarker = Color(0xffB99855);
  static const Color primary = Color(0xffB99855);
  static const Color accentLighter = Color(0xFFB99855);
  static const Color accent = Color(0xFFB99855);
  static const Color backgroundColorPageDark = Color(0xFF111111);
  static const Color errorColor = Color(0xFFC73D3D);
  static const Color dashBoardGreyTextColor = Color(0xFF828282);
  static const Color cardColor = Color(0xFF222222);
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
