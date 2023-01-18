import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool?> showSeeMoreModal({
  required BuildContext context,
  required Widget child,
}) async {
  return await showDialog<bool?>(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                child,
              ],
            ),
          ),
        ),
        // actionsOverflowButtonSpacing: 0,
      );
    },
  );
}
