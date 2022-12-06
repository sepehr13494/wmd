import 'package:equatable/equatable.dart';

class OnBoardingConfigModel extends Equatable {
  final String text;
  final String image;

  const OnBoardingConfigModel({
    required this.text,
    required this.image,
  });

  factory OnBoardingConfigModel.fromJson(Map<String, dynamic> json) =>
      OnBoardingConfigModel(
        text: json["text"],
        image: json["image"],
      );

  static const assetjson = [
    {
      "text": "We support multiple asset classes and currencies.",
      "image": "assets/images/dashboard/dashboard_empty_home.svg"
    },
    {
      "text":
          "Connect with your institutions and avoid the hassle of manual updates.",
      "image": "assets/images/dashboard/dashboard_empty_bank.svg"
    },
    {
      "text":
          "We use the highest security encryption with your data to make sure it is always safe.",
      "image": "assets/images/dashboard/dashboard_empty_sheild.svg"
    },
  ];

  static const wealthjson = [
    {
      "text":
          "Add all your investments, assets and liabilities from all of your wealth managers in one place.",
      "image":
          "assets/images/dashboard/onboarding/onboarding_wealth_overview.svg"
    },
    {
      "text":
          "Asset allocation charts by class, geography & currency help you understand your portfolio diversity.",
      "image": "assets/images/dashboard/onboarding/onboarding_wealth_asset.svg"
    },
    {
      "text":
          "Get personalized insights about your wealth which will help you manage your wealth better.",
      "image": "assets/images/dashboard/onboarding/onboarding_wealth_charts.svg"
    },
  ];

  static const securityjson = [
    {
      "text":
          "We use the highest security standard “lorem ipsum” and “xyz” encryption with your data to make sure it is always safe.",
      "image":
          "assets/images/dashboard/onboarding/onboarding_security_verified.svg"
    },
    {
      "text":
          "The family office employees have no access to your wealth information. Only you see your data.",
      "image": "assets/images/dashboard/onboarding/onboarding_security_lock.svg"
    },
    {
      "text":
          "If you chose to link your bank accounts, we do not see your credentials and make any transactions. We only pull your account balance and transactions.",
      "image":
          "assets/images/dashboard/onboarding/onboarding_security_password.svg"
    },
  ];

  static final assetConfigList =
      assetjson.map((e) => OnBoardingConfigModel.fromJson(e)).toList();
  static final wealthConfigList =
      wealthjson.map((e) => OnBoardingConfigModel.fromJson(e)).toList();
  static final securityConfigList =
      securityjson.map((e) => OnBoardingConfigModel.fromJson(e)).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [text, image];
}
