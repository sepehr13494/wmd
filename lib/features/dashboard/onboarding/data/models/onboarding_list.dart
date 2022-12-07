import 'package:equatable/equatable.dart';

class OnBoardingConfigModel extends Equatable {
  final int count;
  final String title;
  final String body;

  const OnBoardingConfigModel({
    required this.count,
    required this.title,
    required this.body,
  });

  factory OnBoardingConfigModel.fromJson(Map<String, dynamic> json) =>
      OnBoardingConfigModel(
        count: json["count"],
        title: json["title"],
        body: json["body"],
      );

  static const json = [
    {
      "count": 1,
      "title": "Select asset classes",
      "body":
          "Help us with the type of assets and liabilities you own. This is to get your started. You can always add more.",
    },
    {
      "count": 2,
      "title": "Add your first asset",
      "body":
          "Take a minute to add one of your assets. You can simillarly add your assets.",
    },
    {
      "count": 3,
      "title": "View your dashboard ",
      "body":
          "A guided walkthrough of your wealth overview based on the asset added. Add all your assets here and visualize your wealth.",
    },
  ];

  static final assetConfigList =
      json.map((e) => OnBoardingConfigModel.fromJson(e)).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [count, title, body];
}
