import '../../domain/entities/get_custodian_bank_status_entity.dart';

class GetCustodianBankStatusResponse extends CustodianBankStatusEntity {
  const GetCustodianBankStatusResponse({
    required String bankId,
    required bool signLetter,
    required String signLetterLink,
    required bool shareWithBank,
    required bool bankConfirmation,
  }) : super(
            bankId: bankId,
            signLetter: signLetter,
            signLetterLink: signLetterLink,
            shareWithBank: shareWithBank,
            bankConfirmation: bankConfirmation);

  factory GetCustodianBankStatusResponse.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankStatusResponse(
        bankId: json["bankId"],
        signLetter: json["signLetter"],
        signLetterLink: json["signLetterLink"],
        shareWithBank: json["shareWithBank"],
        bankConfirmation: json["bankConfirmation"],
      );
}
