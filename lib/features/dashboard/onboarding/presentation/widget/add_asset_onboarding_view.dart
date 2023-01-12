import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';

class AddAssetOnBoarding extends AppStatelessWidget {
  const AddAssetOnBoarding({Key? key}) : super(key: key);

  static List<Map<String, dynamic>> itemList(
          AppLocalizations appLocalizations) =>
      [
        {
          "count": 1,
          "title": appLocalizations
              .common_guidedOnBoardingModalStepper_selectAsset_title,
          "body": appLocalizations
              .manage_guidedOnBoarding_steps_selectAsset_description
          // "Help us with the type of assets and liabilities you own. This is to get your started. You can always add more.",
        },
        {
          "count": 2,
          "title": appLocalizations
              .common_guidedOnBoardingModalStepper_firstAsset_title,
          "body": appLocalizations
              .manage_guidedOnBoarding_steps_firstAsset_description,
          // "Take a minute to add one of your assets. You can simillarly add your assets.",
        },
        {
          "count": 3,
          "title": appLocalizations
              .common_guidedOnBoardingModalStepper_viewDashboard_title,
          "body": appLocalizations
              .manage_guidedOnBoarding_steps_viewDashboard_description,
          // "A guided walkthrough of your wealth overview based on the asset added. Add all your assets here and visualize your wealth.",
        },
      ];

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            appLocalizations.manage_guidedOnBoarding_heading,
            // 'Let\'s set up your dashboard',
            style:
                textTheme.headlineSmall!.apply(fontWeightDelta: 1).copyWith(),
          ),
          const SizedBox(height: 16),
          Column(
              children: itemList(appLocalizations)
                  .map((e) => OnboardingStepItem(
                        count: e["count"],
                        title: e["title"],
                        body: e["body"],
                      ))
                  .toList())
        ]));
  }
}

class OnboardingStepItem extends AppStatelessWidget {
  final int count;
  final String title;
  final String body;

  const OnboardingStepItem({
    Key? key,
    required this.count,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return SizedBox(
        // width: 100,
        height: 100,
        child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    shape: BoxShape.circle,
                    color: count == 1
                        ? Theme.of(context).primaryColor
                        : AppColors.dashBoardGreyTextColor),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        count.toString(),
                        style: const TextStyle(
                            color: AppColors.backgroundColorPageDark),
                      )
                    ]),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: responsiveHelper.isMobile
                    ? responsiveHelper.optimalDeviceWidth * 0.8
                    : responsiveHelper.optimalDeviceWidth * 0.25,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: textTheme.titleSmall),
                      const SizedBox(height: 10),
                      Expanded(child: Text(body, style: textTheme.bodySmall)),
                    ]),
              ),
            ])));
  }
}
