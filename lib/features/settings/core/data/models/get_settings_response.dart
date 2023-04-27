import '../../domain/entities/get_settings_entity.dart';

class GetSettingsResponse extends GetSettingsEntity {
  const GetSettingsResponse(
      {required super.isPrivacyMode,
      required super.twoFactorEnabled,
      required super.smsTwoFactorEnabled});

  // GetSettingsResponse();

  factory GetSettingsResponse.fromJson(Map<String, dynamic> json) =>
      GetSettingsResponse(
        twoFactorEnabled: json["twoFactorEnabled"],
        isPrivacyMode: json["isPrivacyMode"],
        smsTwoFactorEnabled: json["smsTwoFactorEnabled"],
      );

  static final tResponse = [
    const GetSettingsResponse(
        twoFactorEnabled: true, isPrivacyMode: true, smsTwoFactorEnabled: true)
  ];
}
