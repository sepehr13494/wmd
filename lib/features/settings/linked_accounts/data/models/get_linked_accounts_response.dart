import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';

import '../../domain/entities/get_linked_accounts_entity.dart';

class GetLinkedAccountsResponse extends GetLinkedAccountsEntity {
  const GetLinkedAccountsResponse(
      {required super.bankName,
      required super.id,
      required super.dateLinked,
      super.syncDate,
      required super.status,
      required super.type,
      required super.subType});
  // GetLinkedAccountsResponse();

  factory GetLinkedAccountsResponse.fromJson(Map<String, dynamic> json) =>
      GetLinkedAccountsResponse(
        bankName: json['bankName'],
        id: json['id'],
        dateLinked: DateTime.parse(json['dateLinked']),
        syncDate: json["syncDate"] != null
            ? DateTime.parse(json["syncDate"])
            : json["syncDate"],
        status: getCustodianStatusFromString(json["status"]),
        subType: json['subType'],
        type: json['type'],
      );

  static final tResponse = [
    GetLinkedAccountsResponse(
        bankName: 'IsBank',
        id: 'id',
        dateLinked: DateTime.now(),
        status: CustodianStatus.SyncBank,
        type: 'BankAccount',
        subType: 'Assets')
  ];
}
