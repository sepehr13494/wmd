import '../../domain/entities/get_custodian_bank_status_entity.dart';

class GetCustodianBankStatusResponse extends CustodianBankStatusEntity {
  const GetCustodianBankStatusResponse({
    required String id,
    required String bankId,
    required String bankName,
    required CustodianStatus status,
    required String signLetterLink,
    required String tutorialLink,
    String? accountNumber,
    DateTime? shareDate,
    DateTime? syncDate,
    String? type,
    String? subType,
  }) : super(
            id: id,
            bankId: bankId,
            bankName: bankName,
            status: status,
            signLetterLink: signLetterLink,
            tutorialLink: tutorialLink,
            accountNumber: accountNumber,
            shareDate: shareDate,
            syncDate: syncDate,
            type: type,
            subType: subType);

  factory GetCustodianBankStatusResponse.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankStatusResponse(
        id: json["id"],
        bankId: json["bankId"],
        bankName: json["bankName"],
        status: getCustodianStatusFromString(json["status"]),
        signLetterLink: json["signLetterLink"],
        tutorialLink: json["tutorialLink"],
        accountNumber: json["accountNumber"],
        shareDate: json["shareDate"] != null
            ? DateTime.parse(json["shareDate"])
            : json["shareDate"],
        syncDate: json["syncDate"] != null
            ? DateTime.parse(json["syncDate"])
            : json["syncDate"],
        type: json["type"],
        subType: json["subType"],
      );
}
