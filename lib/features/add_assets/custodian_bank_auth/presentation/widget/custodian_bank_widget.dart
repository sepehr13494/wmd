import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/custodian_bank_entity.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/widget/custodian_auth_status_modal.dart';

class CustodianBankWidget extends StatefulWidget {
  const CustodianBankWidget(this.bank, {required super.key});
  final CustodianBankEntity bank;

  @override
  AppState<CustodianBankWidget> createState() => _CustodianBankWidgetState();
}

class _CustodianBankWidgetState extends AppState<CustodianBankWidget> {
  bool isSelected = false;
  late final CustodianBankEntity bank;
  @override
  void initState() {
    super.initState();
    bank = widget.bank;
  }

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
            setState(() {
              isSelected = !isSelected;
            });
          },
          title: Text(bank.bankName),
          leading: Icon(Icons.account_balance, color: primaryColor),
          // subtitle: Text(bank.bankId),
          trailing: !isSelected
              ? null
              : Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () {
                        showCustodianBankStatus(
                            context: context, bankId: bank.bankId);
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
