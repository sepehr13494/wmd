import 'package:equatable/equatable.dart';

class GetLinkedAccountsEntity extends Equatable {
  final String id;
  final String bankName;
  final DateTime dateLinked;
  final String type;
  final String subType;
  const GetLinkedAccountsEntity(
      {required this.bankName,
      required this.id,
      required this.dateLinked,
      required this.type,
      required this.subType});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [
        id,
        bankName,
        dateLinked,
        type,
        subType,
      ];
}
