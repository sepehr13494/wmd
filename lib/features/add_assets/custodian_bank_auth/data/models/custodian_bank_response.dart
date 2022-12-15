import '../../domain/entities/custodian_bank_entity.dart';

class CustodianBankResponse extends CustodianBankEntity {
  const CustodianBankResponse({
    required String bankId,
    required String bankName,
  }) : super(bankId: bankId, bankName: bankName);

  factory CustodianBankResponse.fromJson(Map<String, dynamic> json) =>
      CustodianBankResponse(
        bankId: json["bankId"],
        bankName: json["bankName"],
      );

  static final tResponse = {
    "bankId": "hsbc",
    "bankName": "HSBC",
  };
}
