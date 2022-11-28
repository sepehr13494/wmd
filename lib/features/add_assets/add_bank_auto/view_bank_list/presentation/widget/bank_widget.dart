import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/presentation/widget/plaid_connect_button.dart';
import '../../domain/entity/bank_entity.dart';

class BankWidget extends StatefulWidget {
  const BankWidget(this.bank, {required super.key});
  final BankEntity bank;

  @override
  AppState<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends AppState<BankWidget> {
  bool isSelected = false;
  late final BankEntity bank;
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
        color: isSelected ? primaryColor.withOpacity(0.2) : null,
        child: ListTile(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          title: Text(bank.name),
          leading: bank.logo == null
              ? Icon(Icons.account_balance, color: primaryColor)
              : Image.network(bank.logo!),
          subtitle: Text(bank.providerCode ?? 'No provider'),
          trailing: !isSelected
              ? null
              : Builder(
                  builder: (context) {
                    switch (bank.provider) {
                      case BankProviders.plaid:
                        // return const Text('Plain connect');
                        return PlaidConnectButton(bank);
                      case BankProviders.lean:
                        return const Text('Lean connect');
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
          selected: isSelected,
          selectedColor: null,
        ),
      ),
    );
  }
}
