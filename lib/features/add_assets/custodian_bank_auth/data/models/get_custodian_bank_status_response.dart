import '../../domain/entities/get_custodian_bank_status_entity.dart';

class GetCustodianBankStatusResponse extends CustodianBankStatusEntity {
  const GetCustodianBankStatusResponse({
    required String id,
    required String bankId,
    required String bankName,
    required bool signLetter,
    required String signLetterLink,
    required bool shareWithBank,
    required bool bankConfirmation,
  }) : super(
            id: id,
            bankId: bankId,
            bankName: bankName,
            signLetter: signLetter,
            signLetterLink: signLetterLink,
            shareWithBank: shareWithBank,
            bankConfirmation: bankConfirmation);

  factory GetCustodianBankStatusResponse.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankStatusResponse(
        id: json["id"],
        bankId: json["bankId"],
        bankName: json["bankName"],
        signLetter: json["signLetter"],
        signLetterLink: json["signLetterLink"],
        shareWithBank: json["shareWithBank"],
        bankConfirmation: json["bankConfirmation"],
      );
}
