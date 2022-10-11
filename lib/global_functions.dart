import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';

class GlobalFunctions {
  GlobalFunctions._();

  static showSnackBar(context, content, {color = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: color,
    ));
  }

  static Future<bool> confirmProcess({
    required BuildContext context,
    required String title,
    required String body,
  }) async {
    bool isConfirm = await showDialog(
      context: context,
      builder: (context) {
        final appTextTheme = Theme.of(context).textTheme;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: SimpleDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Center(
              child: Text(
                title,
                style: appTextTheme.bodyText1,
              ),
            ),
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        body,
                        textAlign: TextAlign.center,
                        style: appTextTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.primary,
                      ),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0.0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((isConfirm) {
      if (isConfirm != null) {
        return true;
      } else {
        return false;
      }
    });

    return isConfirm;
  }
}
