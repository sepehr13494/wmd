import 'package:equatable/equatable.dart';

class GetSettingsEntity extends Equatable {
  final bool isPrivacyMode;
  final bool twoFactorEnabled;
  final bool smsTwoFactorEnabled;

  const GetSettingsEntity(
      {required this.isPrivacyMode,
      required this.twoFactorEnabled,
      required this.smsTwoFactorEnabled});

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];
}
