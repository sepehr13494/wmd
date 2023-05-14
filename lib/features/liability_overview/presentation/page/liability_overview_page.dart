import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/add_button.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_blur_warning.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/dashboard_app_bar.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';

import '../widget/liability_summary_widget.dart';

class LiabilityOverviewPage extends AppStatelessWidget {
  const LiabilityOverviewPage({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final appTheme = Theme.of(context);
    return WillPopScope(
      onWillPop: () {
        debugPrint(
            'Backbutton pressed (device or appbar button), do whatever you want.');
        context.read<MainPageCubit>().onItemTapped(0);
        //we need to return a future
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: DashboardAppBar(
              showBack: true,
              handleGoBack: () =>
                  context.read<MainPageCubit>().onItemTapped(0)),
          body: Stack(
            children: [
              const LeafBackground(),
              WidthLimiterWidget(
                width: 800,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: appTheme.outlinedButtonTheme.style!.copyWith(
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 38))),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: appTheme.outlinedButtonTheme.style!.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 38))),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const PrivacyBlurWarning(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appLocalizations.liabilities_page_title,
                              style: textTheme.titleLarge,
                            ),
                            if (AppConstants.publicMvp2Items)
                              AddButton(
                                addAsset: false,
                                onTap: () {
                                  AnalyticsUtils.triggerEvent(
                                      action:
                                          AnalyticsUtils.assetAdditionAction,
                                      params:
                                          AnalyticsUtils.addAssetOverviewEvent);

                                  context.pushNamed(AppRoutes.addAssetsView);
                                },
                              ),
                          ],
                        ),
                        const LiabilitySummaryWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
