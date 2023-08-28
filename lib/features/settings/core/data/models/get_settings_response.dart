import '../../domain/entities/get_settings_entity.dart';

class GetSettingsResponse extends GetSettingsEntity {
  const GetSettingsResponse(
      {required super.isPrivacyMode,
      required super.twoFactorEnabled,
      required super.smsTwoFactorEnabled,
      required super.isRealEstateChecked,
      required super.isBankAccountChecked,
      required super.isPrivateEquityChecked,
      required super.isPrivateDebtChecked,
      required super.isListedAssetEquityChecked,
      required super.isListedAssetFixedIncomeChecked,
      required super.isListedAssetOtherChecked,
      required super.isOtherAssetsChecked});

  // GetSettingsResponse();

  factory GetSettingsResponse.fromJson(Map<String, dynamic> json) =>
      GetSettingsResponse(
        twoFactorEnabled: json["twoFactorEnabled"],
        isPrivacyMode: json["isPrivacyMode"],
        smsTwoFactorEnabled: json["smsTwoFactorEnabled"] ?? false,
        isRealEstateChecked: json["isRealEstateChecked"] ?? false,
        isBankAccountChecked: json["isBankAccountChecked"] ?? false,
        isPrivateEquityChecked: json["isPrivateEquityChecked"] ?? false,
        isPrivateDebtChecked: json["isPrivateDebtChecked"] ?? false,
        isListedAssetEquityChecked: json["isListedAssetEquityChecked"] ?? false,
        isListedAssetFixedIncomeChecked:
            json["isListedAssetFixedIncomeChecked"] ?? false,
        isListedAssetOtherChecked: json["isListedAssetOtherChecked"] ?? false,
        isOtherAssetsChecked: json["isOtherAssetsChecked"] ?? false,
      );

  @override
  String toString() {
    return {
      "isPrivacyMode": isPrivacyMode,
      "twoFactorEnabled": twoFactorEnabled,
      "smsTwoFactorEnabled": smsTwoFactorEnabled,
      "isRealEstateChecked": isRealEstateChecked,
      "isBankAccountChecked": isBankAccountChecked,
      "isPrivateEquityChecked": isPrivateEquityChecked,
      "isPrivateDebtChecked": isPrivateDebtChecked,
      "isListedAssetEquityChecked": isListedAssetEquityChecked,
      "isListedAssetFixedIncomeChecked": isListedAssetFixedIncomeChecked,
      "isListedAssetOtherChecked": isListedAssetOtherChecked,
      "isOtherAssetsChecked": isOtherAssetsChecked,
    }.toString();
  }

  static final tResponse = [
    const GetSettingsResponse(
        isPrivacyMode: true,
        twoFactorEnabled: true,
        smsTwoFactorEnabled: true,
        isRealEstateChecked: true,
        isBankAccountChecked: true,
        isPrivateEquityChecked: true,
        isPrivateDebtChecked: true,
        isListedAssetEquityChecked: true,
        isListedAssetFixedIncomeChecked: true,
        isListedAssetOtherChecked: true,
        isOtherAssetsChecked: true),
  ];
}
