import '../../domain/entities/get_preference_entity.dart';

class GetPreferenceResponse extends GetPreferenceEntity {
  const GetPreferenceResponse({
    required String language,
    required bool showMobileBanner,
  }) : super(language: language, showMobileBanner: showMobileBanner);

  factory GetPreferenceResponse.fromJson(Map<String, dynamic> json) =>
      GetPreferenceResponse(
          language: json["language"] ?? "",
          showMobileBanner: json["showMobileBanner"]);

  static const tResponse =
      GetPreferenceResponse(language: "en", showMobileBanner: false);
}
