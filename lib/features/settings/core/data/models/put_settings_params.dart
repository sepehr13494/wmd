import 'package:equatable/equatable.dart';

class PutSettingsParams extends Equatable {
  final bool? isPrivacyMode;
  final bool? twoFactorEnabled;
  final bool? emailTwoFactorEnabled;
  final bool? smsTwoFactorEnabled;

  final bool? isRealEstateChecked;
  final bool? isBankAccountChecked;
  final bool? isPrivateEquityChecked;
  final bool? isPrivateDebtChecked;
  final bool? isListedAssetEquityChecked;
  final bool? isListedAssetFixedIncomeChecked;
  final bool? isListedAssetOtherChecked;
  final bool? isOtherAssetsChecked;
  final bool? isLiabilityChecked;

  const PutSettingsParams({
    this.isPrivacyMode,
    this.twoFactorEnabled,
    this.emailTwoFactorEnabled,
    this.smsTwoFactorEnabled,
    this.isRealEstateChecked,
    this.isBankAccountChecked,
    this.isPrivateEquityChecked,
    this.isPrivateDebtChecked,
    this.isListedAssetEquityChecked,
    this.isListedAssetFixedIncomeChecked,
    this.isListedAssetOtherChecked,
    this.isOtherAssetsChecked,
    this.isLiabilityChecked,
  });

  factory PutSettingsParams.fromJson(Map<String, dynamic> json) =>
      PutSettingsParams(
        emailTwoFactorEnabled: json["emailTwoFactorEnabled"],
        isPrivacyMode: json["isPrivacyMode"],
        smsTwoFactorEnabled: json["smsTwoFactorEnabled"],
      );

  Map<String, dynamic> toJson() => {
        // if (isPrivacyMode != null) "isPrivacyMode": isPrivacyMode,
        // if (emailTwoFactorEnabled != null)
        //   "emailTwoFactorEnabled": emailTwoFactorEnabled,
        // if (smsTwoFactorEnabled != null)
        //   "smsTwoFactorEnabled": smsTwoFactorEnabled,
        "isPrivacyMode": isPrivacyMode,
        "twoFactorEnabled": twoFactorEnabled,
        "emailTwoFactorEnabled": emailTwoFactorEnabled,
        "smsTwoFactorEnabled": smsTwoFactorEnabled,
        "isRealEstateChecked": isRealEstateChecked,
        "isBankAccountChecked": isBankAccountChecked,
        "isPrivateEquityChecked": isPrivateEquityChecked,
        "isPrivateDebtChecked": isPrivateDebtChecked,
        "isListedAssetEquityChecked": isListedAssetEquityChecked,
        "isListedAssetFixedIncomeChecked": isListedAssetFixedIncomeChecked,
        "isListedAssetOtherChecked": isListedAssetOtherChecked,
        "isOtherAssetsChecked": isOtherAssetsChecked,
        "isLiabilityChecked": isLiabilityChecked,
      };

  @override
  List<Object?> get props => [
        isPrivacyMode,
        twoFactorEnabled,
        emailTwoFactorEnabled,
        smsTwoFactorEnabled,
      ];

  static const tParams = PutSettingsParams(
      emailTwoFactorEnabled: true,
      twoFactorEnabled: true,
      isPrivacyMode: true,
      smsTwoFactorEnabled: true);
}
