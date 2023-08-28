import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';

class GetLinkedAccountsEntity extends Equatable {
  final String id;
  final String bankName;
  final DateTime dateLinked;
  final DateTime? syncDate;
  final CustodianStatus status;
  final String type;
  final String subType;
  const GetLinkedAccountsEntity(
      {required this.bankName,
      required this.id,
      required this.dateLinked,
      required this.type,
       this.syncDate,
      required this.status,
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
