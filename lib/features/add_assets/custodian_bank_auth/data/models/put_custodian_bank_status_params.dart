import 'package:equatable/equatable.dart';

class PutCustodianBankStatusParams extends Equatable {
  const PutCustodianBankStatusParams({
    required this.id,
    required this.accountId,
    required this.bankId,
    required this.signLetter,
    required this.shareWithBank,
    required this.bankConfirmation,
  });

  final String? id;
  final String? accountId;
  final String bankId;
  final bool signLetter;
  final bool shareWithBank;
  final bool bankConfirmation;

  factory PutCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      PutCustodianBankStatusParams(
        id: json["id"],
        accountId: json["accountId"],
        bankId: json["bankId"],
        signLetter: json["signLetter"],
        shareWithBank: json["shareWithBank"],
        bankConfirmation: json["bankConfirmation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountId": accountId,
        "bankId": bankId,
        "signLetter": signLetter,
        "shareWithBank": shareWithBank,
        "bankConfirmation": bankConfirmation,
      };

  @override
  List<Object?> get props => [
        id,
        accountId,
        bankId,
        signLetter,
        shareWithBank,
        bankConfirmation,
      ];

  static const tResponse = {
    "bankId": "hsbc",
    "signLetter": true,
    "shareWithBank": true,
    "bankConfirmation": false
  };
}
