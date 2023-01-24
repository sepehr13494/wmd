import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:restart_app/restart_app.dart';

class AppRestart {
  static restart(BuildContext context) {
    if (Platform.isIOS) {
      Phoenix.rebirth(context);
    } else {
      Restart.restartApp();
    }
  }
}
