import 'package:flutter/material.dart';
import 'package:wmd/global_functions.dart';

Future<bool> handleBackButton(BuildContext context) {
  // Perform custom actions here
  // Return true to prevent the default back swipe behavior
  // Return false to allow the default back swipe behavior

  bool canClose = false;

  GlobalFunctions.showExitDialog(
      context: context,
      onExitClick: () {
        canClose = true;
      });

  debugPrint(canClose.toString());
  debugPrint(canClose.toString());

  if (canClose) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}
