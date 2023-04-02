import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

Future<bool> showTfoInitialModal({
  required BuildContext context,
  void Function()? onOk,
}) async {
  final appLocalizations = AppLocalizations.of(context);
  final textTheme = Theme.of(context).textTheme;
  final primaryColor = Theme.of(context).primaryColor;
  final isMobile = ResponsiveHelper(context: context).isMobile;
  return await showDialog(
    context: context,
    builder: (context) {
      final content = CenterModalWidget(
        body: const Text('Do you want to load you existing TFO portfolio?'),
        actions: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    appLocalizations.common_button_cancel,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50)),
                  child: Text(appLocalizations.common_button_ok),
                ),
              ),
            ],
          ),
        ),
      );
      if (isMobile) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 2),
        child: content,
      );
    },
  ).then((isConfirm) {
    if (isConfirm != null && isConfirm == true) {
      return true;
    }
    return false;
  });
}
