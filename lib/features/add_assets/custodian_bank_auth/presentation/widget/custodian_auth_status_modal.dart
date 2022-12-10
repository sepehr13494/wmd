import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showCustodianBankStatus({required BuildContext context}) async {
  final textTheme = Theme.of(context).textTheme;
  final appLocalization = AppLocalizations.of(context);
  await showDialog(
    context: context,
    builder: (context) {
      return BottomModalWidget(
        confirmBtn: 'Ok',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Link your Credit Suisse bank account',
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Now you can proceed with linking your bank account following the steps below ',
              style: textTheme.labelMedium,
            ),
          ],
        ),
        // cancelBtn: 'Cancel',
      );
    },
  ).then((isConfirm) {
    if (isConfirm != null && isConfirm == true) {
      // onExitClick();
    }
  });
}
