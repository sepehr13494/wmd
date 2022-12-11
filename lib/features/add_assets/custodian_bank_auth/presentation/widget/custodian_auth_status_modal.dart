import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/custodian_bank_entity.dart';

showCustodianBankStatus(
    {required BuildContext context, required CustodianBankEntity bank}) async {
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
            // bank.
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
