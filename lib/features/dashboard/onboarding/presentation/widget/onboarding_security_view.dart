import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/dashboard/onboarding/data/models/onboarding_config.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/empty_state_dashboard.dart';

class OnBoardingSecurityView extends AppStatelessWidget {
  const OnBoardingSecurityView({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appLocalizations.home_guidedOnBoarding_securityAndPrivacy_title,
          style: textTheme.headlineSmall!.apply(fontWeightDelta: 1).copyWith(
              fontSize: responsiveHelper.getFontSize(30),
              height: responsiveHelper.getLineHeight(1.2)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        EmptyStateDashboard(
            type: "security",
            responsiveHelper: responsiveHelper,
            config: OnBoardingConfigModel.securityConfigList),
        const SizedBox(height: 24),
      ],
    );
  }
}
