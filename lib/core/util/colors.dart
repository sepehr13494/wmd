import 'package:flutter/material.dart';

class AppColors{
  AppColors._();
  static const Color primaryLighter = Color(0xff86e8ca);
  static const Color primaryDarker = Color(0xff4d8673);
  static const Color primary = Color(0xff6ebea5);
  static const Color accentLighter = Color(0xfffad264);
  static const Color accent = Color(0xfff59650);


  static const MaterialColor primarySwatch = MaterialColor(
    0xff5fa38e,
    <int, Color>{
      50: Color(0xffe6faf6),
      100: Color(0xffa8f3e0),
      200: Color(0xff95f1d2),
      300: Color(0xff85e5c7),
      400: Color(0xff7cd5ba),
      500: Color(0xff6ebea5),
      600: Color(0xff5fa38e),
      700: Color(0xff457667),
      800: Color(0xff335a4e),
      900: Color(0xff254038),
    },
  );
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