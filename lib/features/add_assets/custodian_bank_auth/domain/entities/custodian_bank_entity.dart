import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustodianBankEntity extends Equatable {
  const CustodianBankEntity({
    required this.bankId,
    required this.bankName,
  });

  final String bankId;
  final String bankName;

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "bankName": bankName,
      };

  @override
  List<Object?> get props => [
        bankId,
        bankName,
      ];

  String getBankName(context) {
    String res = "";

    switch (bankName) {
      case "HSBC":
        res = AppLocalizations.of(context).linkAccount_custodians_hsbc;
        break;
      case "JP Morgan":
        res = AppLocalizations.of(context).linkAccount_custodians_jpmorgan;
        break;
      case "Julius Baer":
        res = AppLocalizations.of(context).linkAccount_custodians_juliusbar;
        break;
      case "Pictet":
        res = AppLocalizations.of(context).linkAccount_custodians_pictet;
        break;
      case "UBS":
        res = AppLocalizations.of(context).linkAccount_custodians_ubs;
        break;
      default:
    }

    return res;
  }
}
