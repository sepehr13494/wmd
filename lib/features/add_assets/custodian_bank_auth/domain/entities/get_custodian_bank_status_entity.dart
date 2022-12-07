import 'package:equatable/equatable.dart';

class GetCustodianBankStatusEntity extends Equatable {
  const GetCustodianBankStatusEntity({
    required this.bankId,
    required this.signLetter,
    required this.downloadLink,
    required this.shareWithBank,
    required this.bankConfirmation,
  });

  final String bankId;
  final bool signLetter;
  final String downloadLink;
  final bool shareWithBank;
  final bool bankConfirmation;

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "signLetter": signLetter,
        "downloadLink": downloadLink,
        "shareWithBank": shareWithBank,
        "bankConfirmation": bankConfirmation,
      };

  @override
  List<Object?> get props => [
        bankId,
        signLetter,
        downloadLink,
        shareWithBank,
        bankConfirmation,
      ];
}
