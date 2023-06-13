import 'package:equatable/equatable.dart';

class PatchPreferenceLanguageParams extends Equatable {
  final String language;
  const PatchPreferenceLanguageParams({required this.language});

  factory PatchPreferenceLanguageParams.fromJson(Map<String, dynamic> json) =>
      PatchPreferenceLanguageParams(language: json['language']);

  Map<String, dynamic> toJson() => {
        'language': language,
      };

  @override
  List<Object?> get props => [
        language,
      ];

  static final tParams = const PatchPreferenceLanguageParams(language: 'en');
}
