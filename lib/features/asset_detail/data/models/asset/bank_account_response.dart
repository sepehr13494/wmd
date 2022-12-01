import 'package:wmd/features/asset_detail/data/models/get_detail_response.dart';
import 'package:wmd/features/asset_detail/domain/entities/assets/bank_account_entity.dart';
import 'package:wmd/features/asset_detail/domain/entities/get_detail_entity.dart';

class BankAccountResponse extends BankAccountEntity
    implements GetDetailResponse {
  const BankAccountResponse(
    String? bankName,
    String? description,
    String? accountType,
    int? currentBalance,
    bool? isJointAccount,
    int? noOfCoOwners,
    int? ownershipPercentage,
    int? interestRate,
    String? startDate,
    String? endDate,
    String? id,
    String? type,
    bool? isActive,
    String? country,
    String? region,
    String? currencyCode,
  ) : super(
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
        );

  factory BankAccountResponse.fromJson(Map<String, dynamic> json) {
    final bankName = json['bankName']?.toString();
    final description = json['description']?.toString();
    final accountType = json['accountType']?.toString();
    final currentBalance = json['currentBalance']?.toInt();
    final isJointAccount = json['isJointAccount'];
    final noOfCoOwners = json['noOfCoOwners']?.toInt();
    final ownershipPercentage = json['ownershipPercentage']?.toInt();
    final interestRate = json['interestRate']?.toInt();
    final startDate = json['startDate']?.toString();
    final endDate = json['endDate']?.toString();
    final id = json['id']?.toString();
    final type = json['type']?.toString();
    final isActive = json['isActive'];
    final country = json['country']?.toString();
    final region = json['region']?.toString();
    final currencyCode = json['currencyCode']?.toString();
    final value = json.toString();
    return BankAccountResponse(
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
    );
  }

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
