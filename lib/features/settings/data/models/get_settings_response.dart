import '../../domain/entities/get_settings_entity.dart';

class GetSettingsResponse extends GetSettingsEntity {
  const GetSettingsResponse(
      {required super.isPrivacyMode,
      required super.twoFactorEnabled,
      required super.emailTwoFactorEnabled,
      required super.smsTwoFactorEnabled});

  // GetSettingsResponse();

  factory GetSettingsResponse.fromJson(Map<String, dynamic> json) =>
      GetSettingsResponse(
        twoFactorEnabled: json["twoFactorEnabled"]??false,
        emailTwoFactorEnabled: json["emailTwoFactorEnabled"]??false,
        isPrivacyMode: json["isPrivacyMode"]??false,
        smsTwoFactorEnabled: json["smsTwoFactorEnabled"]??false,
      );

  static final tResponse = [
    const GetSettingsResponse(
        twoFactorEnabled: true,
        emailTwoFactorEnabled: true,
        isPrivacyMode: true,
        smsTwoFactorEnabled: true)
  ];
}
