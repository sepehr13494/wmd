import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/custodian_bank_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_auth_status_modal.dart';

class CustodianBankWidgetV2 extends AppStatelessWidget {
  const CustodianBankWidgetV2(
      {super.key,
      required this.bank,
      required this.isSelected,
      required this.onActive});
  final CustodianBankEntity bank;
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
          title: Text(bank.bankName),
          leading: Icon(Icons.account_balance, color: primaryColor),
          trailing: !isSelected
              ? null
              : Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () async {
                        final rs = await showCustodianBankStatus(
                          context: context,
                          bankId: bank.bankId,
                          // onOk: () => context.goNamed(AppRoutes.main),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Text('Connect'),
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
