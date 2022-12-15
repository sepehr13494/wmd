import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/status_entity.dart';

import '../../domain/entities/custodian_bank_entity.dart';

class StatusResponse extends StatusEntity {
  const StatusResponse({
    required super.id,
    required super.bankId,
    required super.bankName,
    required super.signLetter,
    required super.signLetterLink,
    required super.shareWithBank,
    required super.bankConfirmation,
  });

  factory StatusResponse.fromJson(Map<String, dynamic> json) => StatusResponse(
        id: json["id"],
        bankId: json["bankId"],
        bankName: json["bankName"],
        signLetter: json['signLetter'],
        signLetterLink: json['signLetterLink'],
        shareWithBank: json['shareWithBank'],
        bankConfirmation: json['bankConfirmation'],
      );

  static final tResponse = {
    "id": "00000000000",
    "bankId": "hsbc",
    "bankName": "HSBC",
  };
}
