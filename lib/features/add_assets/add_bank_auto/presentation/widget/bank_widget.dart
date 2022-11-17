import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entity/bank_entity.dart';

class BankWidget extends AppStatelessWidget {
  const BankWidget(this.bank, {Key? key}) : super(key: key);
  final BankEntity bank;
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      color: null,
      child: ListTile(
        onTap: () {},
        title: Text(bank.name),
        leading: bank.logo == null
            ? Icon(Icons.account_balance, color: primaryColor)
            : Image.network(bank.logo!),
        // hoverColor: primaryColor,
        // textColor: null,
        // selectedColor: primaryColor,
        // selectedTileColor: primaryColor,
        // focusColor: primaryColor,
        // tileColor: primaryColor,
        // selected: true,
      ),
    );
  }
}
