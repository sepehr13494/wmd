import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';

import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/valuation/presentation/widgets/valuation_warning_modal.dart';

import 'core/presentation/widgets/confirm_modal.dart';

class GlobalFunctions {
  GlobalFunctions._();

  static showSnackBar(BuildContext context, String content,
      {color = Colors.white, type = 'default'}) {
    return showSnackTile(context,
        title: content,
        subtitle: null,
        color: type == "success" ? Colors.green : color,
        icon: type == "error"
            ? Icons.cancel_rounded
            : type == "success"
                ? Icons.check_circle
                : Icons.info);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Row(
    //     children: [
    //       Icon(type == "error"
    //           ? Icons.cancel_rounded
    //           : type == "success"
    //               ? Icons.check_circle
    //               : Icons.info),
    //       const SizedBox(width: 10),
    //       Expanded(child: Text(content))
    //     ],
    //   ),
    //   backgroundColor: type == "error"
    //       ? Colors.red[800]
    //       : type == "success"
    //           ? const Color.fromARGB(179, 67, 160, 72)
    //           : color,
    // ));
  }

  static showSnackTile(
    context, {
    required String title,
    String? subtitle,
    Color color = const Color.fromARGB(179, 67, 160, 72),
    IconData icon = Icons.check_circle,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: color,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(title, style: textTheme.bodyLarge),
                            ],
                          ),
                        ),
                        if (subtitle != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                subtitle,
                                style: textTheme.bodySmall,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<bool> confirmProcess({
    required BuildContext context,
    required String title,
    required String body,
    Widget? icon,
    String yes = 'Yes',
    String no = 'No',
    bool reverse = false,
    bool boldTitle = false,
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
                      Navigator.pop(context, false);
                    },
                  ),
                ),
              ),
              icon ?? const SizedBox(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Center(
                  child: Text(
                    title,
                    style: boldTitle
                        ? appTextTheme.titleLarge
                        : appTextTheme.bodyMedium,
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
              Directionality(
                textDirection: !reverse ? TextDirection.ltr : TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 40)),
                      child: Text(yes),
                    ),
                    const SizedBox(width: 20.0),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(100, 40)),
                      child: Text(
                        no,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).then((isConfirm) {
      if (isConfirm != null && isConfirm == true) {
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
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ModalWidget(
            title: AppLocalizations.of(context).common_formExitModal_title,
            body: AppLocalizations.of(context).common_formExitModal_description,
            confirmBtn: AppLocalizations.of(context)
                .common_formExitModal_buttons_exitForm,
            cancelBtn: AppLocalizations.of(context).common_button_cancel);
      },
    ).then((isConfirm) {
      if (isConfirm != null && isConfirm == true) {
        onExitClick();
      }
      return isConfirm;
    });
  }

  static showConfirmDialog(
      {required BuildContext context,
      required String title,
      required String body,
      required String confirm,
      required String cancel,
      required VoidCallback onConfirm}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ConfirmModal(
            title: title, body: body, confirmBtn: confirm, cancelBtn: cancel);
      },
    ).then((isConfirm) {
      if (isConfirm != null && isConfirm == true) {
        onConfirm();
      }
      return isConfirm;
    });
  }

  static bool showPercentageTooltip(double value) {
    return (value >= 99900 || value <= -100);
  }
}
