import 'package:equatable/equatable.dart';

class GetSettingsEntity extends Equatable {
  final bool isPrivacyMode;
  final bool twoFactorEnabled;
  final bool smsTwoFactorEnabled;
  final bool isRealEstateChecked;
  final bool isBankAccountChecked;
  final bool isPrivateEquityChecked;
  final bool isPrivateDebtChecked;
  final bool isListedAssetEquityChecked;
  final bool isListedAssetFixedIncomeChecked;
  final bool isListedAssetOtherChecked;
  final bool isOtherAssetsChecked;

  const GetSettingsEntity({
    required this.isPrivacyMode,
    required this.twoFactorEnabled,
    required this.smsTwoFactorEnabled,
    required this.isRealEstateChecked,
    required this.isBankAccountChecked,
    required this.isPrivateEquityChecked,
    required this.isPrivateDebtChecked,
    required this.isListedAssetEquityChecked,
    required this.isListedAssetFixedIncomeChecked,
    required this.isListedAssetOtherChecked,
    required this.isOtherAssetsChecked,
  });

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];
}
