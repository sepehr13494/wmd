import 'dart:io';

import 'package:flutter/services.dart';

class AdbChecker {
  static const platform = MethodChannel('adb');
  Future<bool> checkadb() async {
    if (!Platform.isAndroid) return false;
    try {
      final int result = await platform.invokeMethod('checkingadb');
      return result == 1 ? true : false;
    } on PlatformException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}

