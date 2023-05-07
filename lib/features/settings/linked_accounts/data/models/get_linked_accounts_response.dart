import '../../domain/entities/get_linked_accounts_entity.dart';

class GetLinkedAccountsResponse extends GetLinkedAccountsEntity {
  const GetLinkedAccountsResponse(
      {required super.bankName,
      required super.dateLinked,
      required super.type,
      required super.subType});
  // GetLinkedAccountsResponse();

  factory GetLinkedAccountsResponse.fromJson(Map<String, dynamic> json) =>
      GetLinkedAccountsResponse(
        bankName: json['bankName'],
        dateLinked: DateTime.parse(json['dateLinked']),
        subType: json['subType'],
        type: json['type'],
      );

  static final tResponse = [
    GetLinkedAccountsResponse(
        bankName: 'IsBank',
        dateLinked: DateTime.now(),
        type: 'BankAccount',
        subType: 'Assets')
  ];
}
