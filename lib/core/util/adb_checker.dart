import 'dart:io';

import 'package:flutter/services.dart';

class AdbChecker {
  static const platform = MethodChannel('adb');
  Future<bool> adbChecking() async {
    if (!Platform.isAndroid) return false;
    try {
      final int result = await platform.invokeMethod('adbChecking');
      return result == 1 ? true : false;
    } on PlatformException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
