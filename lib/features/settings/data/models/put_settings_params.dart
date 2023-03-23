import 'package:equatable/equatable.dart';

class PutSettingsParams extends Equatable {
  final bool? isPrivacyMode;
  final bool? emailTwoFactorEnabled;
  final bool? smsTwoFactorEnabled;

  const PutSettingsParams(
      {this.isPrivacyMode,
      this.emailTwoFactorEnabled,
      this.smsTwoFactorEnabled});

  factory PutSettingsParams.fromJson(Map<String, dynamic> json) =>
      PutSettingsParams(
        emailTwoFactorEnabled: json["emailTwoFactorEnabled"],
        isPrivacyMode: json["isPrivacyMode"],
        smsTwoFactorEnabled: json["smsTwoFactorEnabled"],
      );

  Map<String, dynamic> toJson() => {
        if (isPrivacyMode != null) "isPrivacyMode": isPrivacyMode,
        if (emailTwoFactorEnabled != null)
          "emailTwoFactorEnabled": emailTwoFactorEnabled,
        if (smsTwoFactorEnabled != null)
          "smsTwoFactorEnabled": smsTwoFactorEnabled,
      };

  @override
  List<Object?> get props => [
        isPrivacyMode,
        emailTwoFactorEnabled,
        smsTwoFactorEnabled,
      ];

  static const tParams = PutSettingsParams(
      emailTwoFactorEnabled: true,
      isPrivacyMode: true,
      smsTwoFactorEnabled: true);
}
