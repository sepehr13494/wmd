import '../../domain/entities/put_settings_entity.dart';

class PutSettingsResponse extends PutSettingsEntity {
  PutSettingsResponse(
      {required super.isPrivacyMode,
      required super.emailTwoFactorEnabled,
      required super.smsTwoFactorEnabled});

  factory PutSettingsResponse.fromJson(Map<String, dynamic> json) =>
      PutSettingsResponse(
        emailTwoFactorEnabled: json["emailTwoFactorEnabled"],
        isPrivacyMode: json["isPrivacyMode"],
        smsTwoFactorEnabled: json["smsTwoFactorEnabled"],
      );

  static final tResponse = PutSettingsResponse(
      emailTwoFactorEnabled: true,
      isPrivacyMode: true,
      smsTwoFactorEnabled: true);
}
