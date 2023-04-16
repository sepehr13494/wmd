import 'package:equatable/equatable.dart';

class OnBoardingConfigModel extends Equatable {
  final int? key;
  final String text;
  final String image;

  const OnBoardingConfigModel({
    this.key,
    required this.text,
    required this.image,
  });

  factory OnBoardingConfigModel.fromJson(Map<String, dynamic> json) =>
      OnBoardingConfigModel(
        key: json["key"],
        text: json["text"],
        image: json["image"],
      );

  static assetjson(appLocalizations) => [
        {
          "key": 1,
          "text":
              appLocalizations.home_guidedOnBoarding_addAndLinkAsset_assetClass,
          "image": "assets/images/dashboard/dashboard_empty_home.svg"
        },
        {
          "key": 2,
          "text": appLocalizations
              .home_guidedOnBoarding_addAndLinkAsset_connectInstitutionsIcon,
          "image": "assets/images/dashboard/dashboard_empty_bank.svg"
        },
        {
          "key": 3,
          "text": appLocalizations
              .home_guidedOnBoarding_addAndLinkAsset_realTimeUpdate,
          "image": "assets/images/dashboard/dashboard_empty_sheild.svg"
        },
      ];

  static wealthjson(appLocalizations) => [
        {
          "key": 1,
          "text": appLocalizations
              .home_guidedOnBoarding_trackAndVisualizeWealth_dashboardView,
          "image": appLocalizations.localeName == "en"
              ? "assets/images/dashboard/onboarding/onboarding_wealth_overview.png"
              : "assets/images/dashboard/onboarding/onboarding_wealth_overview_ar.png"
        },
        {
          "key": 2,
          "text": appLocalizations
              .home_guidedOnBoarding_trackAndVisualizeWealth_dashboardAllocation,
          "image": appLocalizations.localeName == "en"
              ? "assets/images/dashboard/onboarding/onboarding_wealth_charts.png"
              : "assets/images/dashboard/onboarding/onboarding_wealth_charts_ar.png"
        },
        {
          "key": 3,
          "text": appLocalizations
              .home_guidedOnBoarding_trackAndVisualizeWealth_assetDetailPage,
          "image": appLocalizations.localeName == "en"
              ? "assets/images/dashboard/onboarding/onboarding_wealth_asset.png"
              : "assets/images/dashboard/onboarding/onboarding_wealth_asset_ar.png"
        },
      ];

  static securityjson(appLocalizations) => [
        {
          "key": 1,
          "text": appLocalizations
              .home_guidedOnBoarding_securityAndPrivacy_highestSecurity,
          "image":
              "assets/images/dashboard/onboarding/onboarding_security_verified.svg"
        },
        {
          "key": 2,
          "text": appLocalizations
              .home_guidedOnBoarding_securityAndPrivacy_noAccess,
          "image":
              "assets/images/dashboard/onboarding/onboarding_security_lock.svg"
        },
        {
          "key": 3,
          "text": appLocalizations
              .home_guidedOnBoarding_securityAndPrivacy_linkAccount,
          "image":
              "assets/images/dashboard/onboarding/onboarding_security_password.svg"
        },
      ];

  static assetConfigList(appLocalizations) => assetjson(appLocalizations)
      .map((Map<String, dynamic> e) => OnBoardingConfigModel.fromJson(e))
      .toList();
  static wealthConfigList(appLocalizations) => wealthjson(appLocalizations)
      .map((Map<String, dynamic> e) => OnBoardingConfigModel.fromJson(e))
      .toList();
  static securityConfigList(appLocalizations) => securityjson(appLocalizations)
      .map((Map<String, dynamic> e) => OnBoardingConfigModel.fromJson(e))
      .toList();

  @override
  // TODO: implement props
  List<Object?> get props => [text, image, key];
}
