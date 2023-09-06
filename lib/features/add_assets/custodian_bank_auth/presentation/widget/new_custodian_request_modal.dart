import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/bottom_modal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> showNewCustodianModal({
  required BuildContext context,
}) async {
  final appLocalization = AppLocalizations.of(context);
  return await showDialog(
    context: context,
    builder: (context) {
      return CenterModalWidget(
          confirmBtn: appLocalization.common_button_ok,
          body: const RequestCustodianForm(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0)
          // cancelBtn: 'Cancel',
          );
    },
  );
}

class RequestCustodianForm extends AppStatelessWidget {
  const RequestCustodianForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      children: [
        Text(appLocalizations.common_newCustodianRequest_modal_title),
        Text(appLocalizations.common_newCustodianRequest_modal_bankDetails),
        Text(appLocalizations.common_newCustodianRequest_modal_accountNumber),
        Text(appLocalizations.common_newCustodianRequest_modal_bankName),
        Text(appLocalizations.common_newCustodianRequest_modal_bankCountry),
        Text(appLocalizations.common_newCustodianRequest_modal_managerDetails),
        Text(appLocalizations.common_newCustodianRequest_modal_managerName),
        Text(appLocalizations.common_newCustodianRequest_modal_managerEmail),
        Text(appLocalizations.common_newCustodianRequest_modal_check),
      ],
    );
  }
}
