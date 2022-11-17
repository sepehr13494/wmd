import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/add_assets/add_bank_auto/data/models/bank_list_response.dart';

class BankWidget extends AppStatelessWidget {
  const BankWidget(this.bank, {Key? key}) : super(key: key);
  final BankResponse bank;
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
