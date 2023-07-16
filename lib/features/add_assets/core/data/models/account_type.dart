import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountType {
  final String name;
  final String value;

  AccountType({required this.name, required this.value});

  static List<Map<String, dynamic>> json(context) => [
        {
          "value": "SavingAccount",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_bankAccount_inputFields_accountType_options_savingAccount
        },
        {
          "value": "CurrentAccount",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_bankAccount_inputFields_accountType_options_currentAccount
        },
        {
          "value": "TermDeposit",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_bankAccount_inputFields_accountType_options_termDeposit
        },
      ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory AccountType.fromJson(Map<String, dynamic> json) => AccountType(
        value: json["value"],
        name: json["name"],
      );

  static List<AccountType> accountList(context) =>
      json(context).map((e) => AccountType.fromJson(e)).toList();
}
