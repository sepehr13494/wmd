import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/link_tfo_wealth/presentation/widgets/tfo_initial_modal.dart';

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
                        final result = await showTfoInitialModal(
                          context: context,
                          onOk: () {
                            log('Mert log: yes yes');
                          },
                        );
                        log('Mert log: $result');
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
