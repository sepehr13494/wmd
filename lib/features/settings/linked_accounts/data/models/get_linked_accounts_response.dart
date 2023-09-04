import '../../domain/entities/get_linked_accounts_entity.dart';

class GetLinkedAccountsResponse extends GetLinkedAccountsEntity {
  const GetLinkedAccountsResponse(
      {required super.bankName,
      required super.id,
       super.syncDate,
      required super.type,
      required super.accountNumber,
      required super.subType});
  // GetLinkedAccountsResponse();

  factory GetLinkedAccountsResponse.fromJson(Map<String, dynamic> json) =>
      GetLinkedAccountsResponse(
        bankName: json['bankName'],
        id: json['id'],
        syncDate:json['syncDate'] != null ? DateTime.parse(json['syncDate']) : null,
        subType: json['subType'],
        accountNumber: json['accountNumber'],
        type: json['type'],
      );

  static final tResponse = [
    GetLinkedAccountsResponse(
        bankName: 'IsBank',
        id: 'id',
        syncDate: DateTime.now(),
        type: 'BankAccount',
        accountNumber: 'accountNumber',
        subType: 'Assets')
  ];
}
