import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/dashboard/onboarding/data/models/onboarding_config.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/empty_state_dashboard.dart';

class OnBoardingAssetView extends AppStatelessWidget {
  const OnBoardingAssetView({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Link all your assets with ease',
          style: textTheme.headlineSmall!.apply(fontWeightDelta: 4).copyWith(
              fontSize: responsiveHelper.getFontSize(30),
              height: responsiveHelper.getLineHeight(1.2)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Connect with your institutions to see updates for your assets and liabilities',
          style: textTheme.titleMedium!.copyWith(
              fontSize: responsiveHelper.getFontSize(20),
              height: responsiveHelper.getLineHeight(1.2)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        EmptyStateDashboard(
            responsiveHelper: responsiveHelper,
            config: OnBoardingConfigModel.assetConfigList),
        const SizedBox(height: 24),
      ],
    );
  }
}
