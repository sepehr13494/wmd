import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';

class PutCustodianBankStatusParams extends Equatable {
  const PutCustodianBankStatusParams({
    required this.id,
    required this.accountNumber,
    required this.bankId,
    required this.status,
  });

  final String? id;
  final String? accountNumber;
  final String bankId;
  final CustodianStatus status;

  factory PutCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      PutCustodianBankStatusParams(
        id: json["id"],
        accountNumber: json["accountNumber"],
        bankId: json["bankId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountNumber": accountNumber,
        "bankId": bankId,
        "status": status.name,
      };

  @override
  List<Object?> get props => [
        id,
        accountNumber,
        bankId,
        status,
      ];

  static const tResponse = {
    "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "bankId": "string",
    "accountNumber": "string",
    "status": "FillAccount"
  };
}
