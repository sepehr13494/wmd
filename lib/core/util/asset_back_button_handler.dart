import 'package:flutter/material.dart';
import 'package:wmd/global_functions.dart';

Future<bool> handleAssetBackButton(BuildContext context) async {
  // Perform custom actions here
  // Return true to prevent the default back swipe behavior
  // Return false to allow the default back swipe behavior

  bool canClose = false;

  await GlobalFunctions.showExitDialog(
      context: context,
      onExitClick: () {
        canClose = true;
        debugPrint("exit true");
      });

  if (canClose) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}
