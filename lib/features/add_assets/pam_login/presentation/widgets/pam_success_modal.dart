import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';

Future<bool> showPamSuccessModal({required BuildContext context}) async {
  final appLocalizations = AppLocalizations.of(context);
  final textTheme = Theme.of(context).textTheme;
  final primaryColor = Theme.of(context).primaryColor;
  final isMobile = ResponsiveHelper(context: context).isMobile;
  return await showDialog(
    context: context,
    builder: (context) {
      log('MErt log starts here');
      final content = CenterModalWidget(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: AppColors.green),
            const SizedBox(height: 16),
            Text(
              appLocalizations.common_linkPAM_modal_oneMandate_title,
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              appLocalizations.common_linkTFO_modal_oneMandate_description,
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
            child: Text(appLocalizations.common_button_continue),
          ),
        ),
      );
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: content,
      );
      // if (isMobile) {
      // }
      // return Padding(
      //   padding: EdgeInsets.symmetric(
      //       horizontal: MediaQuery.of(context).size.width / 2),
      //   child: content,
      // );
    },
  ).then((isConfirm) {
    if (isConfirm != null && isConfirm == true) {
      return true;
    }
    return false;
  });
}
