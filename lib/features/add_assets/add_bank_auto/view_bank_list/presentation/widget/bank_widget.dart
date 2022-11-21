import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entity/bank_entity.dart';

class BankWidget extends StatefulWidget {
  const BankWidget(this.bank, {required super.key});
  final BankEntity bank;

  @override
  AppState<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends AppState<BankWidget> {
  bool isSelected = false;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final BankEntity bank = widget.bank;
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
          trailing: isSelected ? const Connectbutton() : null,
          selected: isSelected,
          selectedColor: null,
        ),
      ),
    );
  }
}

class Connectbutton extends AppStatelessWidget {
  const Connectbutton({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text('Connect'),
        ),
      ),
    );
  }
}
