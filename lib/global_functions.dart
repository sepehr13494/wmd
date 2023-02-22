import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';

import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlobalFunctions {
  GlobalFunctions._();

  static showSnackBar(context, content,
      {color = Colors.white, type = 'default'}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(type == "error"
              ? Icons.cancel_rounded
              : type == "success"
                  ? Icons.check_circle
                  : Icons.info),
          const SizedBox(width: 10),
          Expanded(child: Text(content))
        ],
      ),
      backgroundColor: type == "error"
          ? Colors.red[800]
          : type == "success"
              ? const Color.fromARGB(179, 67, 160, 72)
              : color,
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
            // backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            title: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: FractionalOffset.topRight,
                  child: GestureDetector(
                    child: const Icon(
                      Icons.clear,
                      color: AppColors.primary,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Center(
                  child: Text(
                    title,
                    style: appTextTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ]),
            children: <Widget>[
              if ((body != ""))
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
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
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40)),
                    child: const Text("Yes"),
                  ),
                  const SizedBox(width: 20.0),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(100, 40)),
                    child: const Text(
                      "No",
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

  static showExitDialog(
      {required BuildContext context,
      required VoidCallback onExitClick}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ModalWidget(
            title: AppLocalizations.of(context).common_formExitModal_title,
            body: AppLocalizations.of(context).common_formExitModal_description,
            confirmBtn: 'Exit',
            cancelBtn: AppLocalizations.of(context).common_button_cancel);
      },
    ).then((isConfirm) {
      if (isConfirm != null && isConfirm == true) {
        onExitClick();
      }
    });
  }
}
