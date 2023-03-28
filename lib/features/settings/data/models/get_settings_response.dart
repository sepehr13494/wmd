import '../../domain/entities/get_settings_entity.dart';

class GetSettingsResponse extends GetSettingsEntity {
  const GetSettingsResponse(
      {required super.isPrivacyMode,
      required super.emailTwoFactorEnabled,
      required super.smsTwoFactorEnabled});

  // GetSettingsResponse();

  factory GetSettingsResponse.fromJson(Map<String, dynamic> json) =>
      GetSettingsResponse(
        emailTwoFactorEnabled: json["emailTwoFactorEnabled"],
        isPrivacyMode: json["isPrivacyMode"],
        smsTwoFactorEnabled: json["smsTwoFactorEnabled"],
      );

  static final tResponse = [
    const GetSettingsResponse(
        emailTwoFactorEnabled: true,
        isPrivacyMode: true,
        smsTwoFactorEnabled: true)
  ];
}
