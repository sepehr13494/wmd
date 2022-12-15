import 'package:equatable/equatable.dart';

class CustodianBankStatusEntity extends Equatable {
  const CustodianBankStatusEntity({
    required this.bankId,
    required this.signLetter,
    required this.signLetterLink,
    required this.shareWithBank,
    required this.bankConfirmation,
  });

  final String bankId;
  final bool signLetter;
  final String signLetterLink;
  final bool shareWithBank;
  final bool bankConfirmation;

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "signLetter": signLetter,
        "signLetterLink": signLetterLink,
        "shareWithBank": shareWithBank,
        "bankConfirmation": bankConfirmation,
      };

  @override
  List<Object?> get props => [
        bankId,
        signLetter,
        signLetterLink,
        shareWithBank,
        bankConfirmation,
      ];

  static const tResponse = {
    "id": "844cc294-7cbf-41a6-9bdd-b6c839444364",
    "bankId": "hsbc",
    "signLetter": true,
    "signLetterLink":
        "https://a.storyblok.com/f/187108/x/169d159c71/creditsuisse.pdf",
    "shareWithBank": true,
    "bankConfirmation": false
  };
}
