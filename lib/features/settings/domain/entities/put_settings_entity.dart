import 'package:equatable/equatable.dart';

class PutSettingsEntity extends Equatable {
  final bool isPrivacyMode;
  final bool emailTwoFactorEnabled;
  final bool smsTwoFactorEnabled;

  const PutSettingsEntity(
      {required this.isPrivacyMode,
      required this.emailTwoFactorEnabled,
      required this.smsTwoFactorEnabled});

  Map<String, dynamic> toJson() => {
        "isPrivacyMode": isPrivacyMode,
        "emailTwoFactorEnabled": emailTwoFactorEnabled,
        "smsTwoFactorEnabled": smsTwoFactorEnabled,
      };

  @override
  List<Object?> get props => [
        isPrivacyMode,
        emailTwoFactorEnabled,
        smsTwoFactorEnabled,
      ];
}
