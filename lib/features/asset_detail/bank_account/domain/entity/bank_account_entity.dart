import 'package:equatable/equatable.dart';

class BankAccountEntity extends Equatable {
  final String bankName;
  final String description;
  final String accountType;
  final double currentBalance;
  final bool isJointAccount;
  final double noOfCoOwners;
  final double ownershipPercentage;
  final double interestRate;
  final DateTime? startDate;
  final DateTime? endDate;
  final String id;
  final String type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double portfolioContribution;
  final double holdings;
  final DateTime? asOfDate;

  const BankAccountEntity({
    required this.bankName,
    required this.description,
    required this.accountType,
    required this.currentBalance,
    required this.isJointAccount,
    required this.noOfCoOwners,
    required this.ownershipPercentage,
    required this.interestRate,
    required this.startDate,
    required this.endDate,
    required this.id,
    required this.type,
    required this.isActive,
    required this.country,
    required this.region,
    required this.currencyCode,
    required this.portfolioContribution,
    required this.holdings,
    required this.asOfDate,
  });

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
        'portfolioContribution': portfolioContribution,
        'holdings': holdings,
        'asOfDate': asOfDate,
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
        portfolioContribution,
        holdings,
        asOfDate,
      ];
}
