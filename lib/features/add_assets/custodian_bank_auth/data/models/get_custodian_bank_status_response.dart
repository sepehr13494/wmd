import '../../domain/entities/get_custodian_bank_status_entity.dart';

class GetCustodianBankStatusResponse extends GetCustodianBankStatusEntity {
  const GetCustodianBankStatusResponse({
    required String bankId,
    required bool signLetter,
    required String downloadLink,
    required bool shareWithBank,
    required bool bankConfirmation,
  }) : super(
            bankId: bankId,
            signLetter: signLetter,
            downloadLink: downloadLink,
            shareWithBank: shareWithBank,
            bankConfirmation: bankConfirmation);

  factory GetCustodianBankStatusResponse.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankStatusResponse(
        bankId: json["bankId"],
        signLetter: json["signLetter"],
        downloadLink: json["downloadLink"],
        shareWithBank: json["shareWithBank"],
        bankConfirmation: json["bankConfirmation"],
      );
}
