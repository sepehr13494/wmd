import 'dart:developer';
// import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/link_tfo_wealth/presentation/widgets/tfo_confirm_mandate_modal.dart';
import 'package:wmd/features/add_assets/link_tfo_wealth/presentation/widgets/tfo_initial_modal.dart';
import 'package:wmd/features/add_assets/link_tfo_wealth/presentation/widgets/tfo_success_modal.dart';
import 'package:wmd/global_functions.dart';

class TfoCustodianBankWidget extends AppStatelessWidget {
  const TfoCustodianBankWidget(
      {super.key, required this.isSelected, required this.onActive});

  final bool isSelected;
  final void Function() onActive;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;

    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        color: isSelected ? primaryColor.withOpacity(0.2) : null,
        child: ListTile(
          onTap: () {
            onActive();
          },
          title: const Text('The Office Family'),
          leading: Icon(Icons.account_balance, color: primaryColor),
          trailing: !isSelected
              ? null
              : Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () async {
                        await AnalyticsUtils.triggerEvent(
                            action: AnalyticsUtils.linkBankAction(
                                'The Office Family custodian'),
                            params: AnalyticsUtils.linkBankEvent(
                                'The Office Family custodian'));
                        final result =
                            await showTfoInitialModal(context: context);
                        if (result) {
                          try {
                          //   // const appScheme = 'com.tfo.wmd';
                          //   final auth0 = Auth0('https://tfo-dev.eu.auth0.com',
                          //       'AWZejjdbi65mSS87zNGCMfgC0qXjgRn1');
                          //   final Credentials credentials =
                          //       await auth0.webAuthentication().login();
                            showTfoConfirmMandateModal(context: context);
                          } on Exception catch (e, s) {
                            log('login error: $e - stack: $s');
                            // ignore: use_build_context_synchronously
                            GlobalFunctions.showSnackTile(context,
                                title: appLocalizations
                                    .common_toast_generic_error_title,
                                color: Colors.red);
                          }
                          // showTfoSuccessModal(context: context);
                        }
                        // log('Mert log: $result');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Text(appLocalizations.common_button_connect),
                        ),
                      ),
                    );
                  },
                ),
          selected: isSelected,
          selectedColor: null,
        ),
      ),
    );
  }
}
