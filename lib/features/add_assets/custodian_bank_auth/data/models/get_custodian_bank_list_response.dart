import '../../domain/entities/get_custodian_bank_list_entity.dart';

class GetCustodianBankListResponse extends GetCustodianBankListEntity {
  const GetCustodianBankListResponse({
    required String bankId,
    required String bankName,
  }) : super(bankId: bankId, bankName: bankName);

  factory GetCustodianBankListResponse.fromJson(Map<String, dynamic> json) =>
      GetCustodianBankListResponse(
        bankId: json["bankId"],
        bankName: json["bankName"],
      );
}
