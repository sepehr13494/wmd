import 'package:equatable/equatable.dart';
import 'package:wmd/features/asset_detail/domain/entities/get_detail_entity.dart';

class BankAccountEntity extends Equatable {
  final String? bankName;
  final String? description;
  final String? accountType;
  final int? currentBalance;
  final bool? isJointAccount;
  final int? noOfCoOwners;
  final int? ownershipPercentage;
  final int? interestRate;
  final String? startDate;
  final String? endDate;
  final String? id;
  final String? type;
  final bool? isActive;
  final String? country;
  final String? region;
  final String? currencyCode;

  const BankAccountEntity(
    this.bankName,
    this.description,
    this.accountType,
    this.currentBalance,
    this.isJointAccount,
    this.noOfCoOwners,
    this.ownershipPercentage,
    this.interestRate,
    this.startDate,
    this.endDate,
    this.id,
    this.type,
    this.isActive,
    this.country,
    this.region,
    this.currencyCode,
  );

  @override
  Map<String, dynamic> toJson() => {
        'bankName': bankName,
        'description': description,
        'accountType': accountType,
        'currentBalance': currentBalance,
        'isJointAccount': isJointAccount,
        'noOfCoOwners': noOfCoOwners,
        'ownershipPercentage': ownershipPercentage,
        'interestRate': interestRate,
        'startDate': startDate,
        'endDate': endDate,
        'id': id,
        'type': type,
        'isActive': isActive,
        'country': country,
        'region': region,
        'currencyCode': currencyCode,
      };

  @override
  List<Object?> get props => [
        bankName,
        description,
        accountType,
        currentBalance,
        isJointAccount,
        noOfCoOwners,
        ownershipPercentage,
        interestRate,
        startDate,
        endDate,
        id,
        type,
        isActive,
        country,
        region,
        currencyCode,
      ];
}
