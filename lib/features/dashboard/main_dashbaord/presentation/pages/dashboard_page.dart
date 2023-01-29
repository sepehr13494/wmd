import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/dashboard/onboarding/data/models/onboarding_config.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/empty_state_dashboard.dart';

class DashboardPage extends AppStatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final ResponsiveHelper responsiveHelper =
        ResponsiveHelper(context: context);
    return Container(
      padding: responsiveHelper.paddingForMobileTab,
      decoration: BoxDecoration(
          color: textTheme.bodySmall!.color!.withOpacity(0.05),
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      margin: responsiveHelper.marginForMobileTab,
      child: Column(
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
              type: "asset",
              responsiveHelper: responsiveHelper,
              config: OnBoardingConfigModel.assetConfigList(appLocalizations)),
          const SizedBox(height: 24),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoutes.addAssetsView);
              },
              child: const Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}
