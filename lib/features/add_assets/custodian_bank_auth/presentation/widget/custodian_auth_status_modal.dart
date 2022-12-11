import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
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
            const SizedBox(height: 8),
            StatusStepWidget(
              stepNumber: '1',
              title: 'Sign letter of authorization',
              trailing: '5 mins',
              subtitle: 'Download and sign letter',
              doneSubtitle: 'Download again',
              isDone: true,
              onDoneAgain: () {
                Navigator.pop(context);
              },
            ),
            const StatusStepWidget(
              stepNumber: '2',
              title: 'Share with the bank',
              trailing: '2 days',
              subtitle: 'Mark as completed',
            ),
            const StatusStepWidget(
              stepNumber: '3',
              title: 'Get confirmation from bank via your RM',
              trailing: '5-10 days',
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

class StatusStepWidget extends AppStatelessWidget {
  final String stepNumber;
  final String title;
  final bool isDone;
  final String? subtitle;
  final String? doneSubtitle;
  final String trailing;
  final void Function()? onDone;
  final void Function()? onDoneAgain;
  const StatusStepWidget({
    required this.title,
    required this.stepNumber,
    required this.trailing,
    this.isDone = false,
    this.doneSubtitle,
    this.subtitle,
    this.onDone,
    this.onDoneAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return ListTile(
      leading: isDone
          ? const Icon(Icons.check_circle_outline_outlined)
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              height: 18,
              width: 18,
              child: Center(
                  child: Text(
                stepNumber,
                style: textTheme.bodySmall!
                    .apply(color: Theme.of(context).backgroundColor),
                textAlign: TextAlign.center,
              )),
            ),
      title: Text(title),
      subtitle: Builder(
        builder: (context) {
          if (isDone) {
            if (doneSubtitle != null) {
              return InkWell(
                onTap: onDoneAgain,
                child: Text(
                  doneSubtitle!,
                  style: textTheme.bodySmall!.apply(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline),
                ),
              );
            }
          } else {
            if (subtitle != null) {
              InkWell(
                onTap: onDone,
                child: Text(
                  subtitle!,
                  style: textTheme.bodySmall!.apply(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline),
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
      trailing: Text(trailing),
    );
  }
}
