import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';

import '../../domain/entities/custodian_bank_entity.dart';

class PostCustodianBankStatusParams extends Equatable {
  const PostCustodianBankStatusParams({
    required this.status,
    this.accountNumber,
    required this.bankId,
  });

  final CustodianStatus status;
  final String? accountNumber;
  final String bankId;

  factory PostCustodianBankStatusParams.fromJson(Map<String, dynamic> json) =>
      PostCustodianBankStatusParams(
        status: json["status"],
        accountNumber: json["accountNumber"],
        bankId: json["bankId"],
      );
  factory PostCustodianBankStatusParams.fromEntity(CustodianBankEntity bank) =>
      PostCustodianBankStatusParams(
        status: CustodianStatus.FillAccount,
        accountNumber: "",
        bankId: bank.bankId,
      );

  Map<String, dynamic> toJson() => {
        "status": status.name,
        "accountNumber": accountNumber,
        "bankId": bankId,
      };

  @override
  List<Object?> get props => [
        status,
        accountNumber,
        bankId,
      ];

  static const tResponse = {
    "status": "FillAccount",
    "accountNumber": "accountNumber",
    "bankId": "hsbc",
  };
}
