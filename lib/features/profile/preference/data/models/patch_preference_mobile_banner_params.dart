import 'package:equatable/equatable.dart';

class PatchPreferenceMobileBannerParams extends Equatable {
  const PatchPreferenceMobileBannerParams({
    required this.showMobileBanner,
  });

  final bool showMobileBanner;

  factory PatchPreferenceMobileBannerParams.fromJson(
          Map<String, dynamic> json) =>
      PatchPreferenceMobileBannerParams(
        showMobileBanner: json["showMobileBanner"],
      );

  Map<String, dynamic> toJson() => {
        "showMobileBanner": showMobileBanner,
      };

  @override
  List<Object?> get props => [
        showMobileBanner,
      ];

  static const tParams =
      PatchPreferenceMobileBannerParams(showMobileBanner: false);
}
