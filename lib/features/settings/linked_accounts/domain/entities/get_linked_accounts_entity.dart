import 'package:equatable/equatable.dart';

class GetLinkedAccountsEntity extends Equatable {
  final String id;
  final String bankName;
  final DateTime? syncDate;
  final String type;
  final String subType;
  final String accountNumber;
  const GetLinkedAccountsEntity(
      {required this.bankName,
      required this.id,
      required this.syncDate,
      required this.type,
      required this.accountNumber,
      required this.subType});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [
        id,
        bankName,
        syncDate,
        type,
        subType,
      ];
}
