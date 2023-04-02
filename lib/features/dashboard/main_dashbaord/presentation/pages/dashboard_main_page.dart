import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_blur_warning.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/main_dashboard_shimmer.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/dashboard_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/filter_add_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/net_worth_base_chart.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/summery_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_asset_class_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_benchmark_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_custodian_widget.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/two_factor_recommendation_widget.dart';
import '../../../dashboard_charts/presentation/widgets/pie_chart_sample.dart';
import '../../../dashboard_charts/presentation/widgets/random_map.dart';
import '../widget/bank_auth_process.dart';
import 'dashboard_page.dart';

class DashboardMainPage extends StatefulWidget {
  final bool expandCustodian;

  const DashboardMainPage({Key? key, this.expandCustodian = false})
      : super(key: key);

  @override
  AppState<DashboardMainPage> createState() => _DashboardMainPageState();
}

class _DashboardMainPageState extends AppState<DashboardMainPage> {
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    final appTheme = Theme.of(context);

    final twoFactorState = context.read<TwoFactorCubit>().state;
    bool showTwoFactorReccoment = true;

    if (widget.expandCustodian) {
      context.read<CustodianStatusListCubit>().getCustodianStatusList();
    }
    return Scaffold(
      appBar: const DashboardAppBar(),
      body: BlocConsumer<UserStatusCubit, UserStatusState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {
          if (state is UserStatusLoaded) {
            if (!(state.userStatus.emailVerified ?? true)) {
              context.goNamed(AppRoutes.verifyEmail,
                  queryParams: {"email": state.userStatus.email ?? ""});
            }
          }
        }),
        builder: (context, state) {
          return state is UserStatusLoaded
              ? (state.userStatus.loginAt != null)
                  ? WidthLimiterWidget(
                      width: 700,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Theme(
                              data: appTheme.copyWith(
                                  outlinedButtonTheme: OutlinedButtonThemeData(
                                    style: appTheme.outlinedButtonTheme.style!
                                        .copyWith(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    const Size(0, 48))),
                                  ),
                                  elevatedButtonTheme: ElevatedButtonThemeData(
                                    style: appTheme.outlinedButtonTheme.style!
                                        .copyWith(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(0, 48)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  iconTheme: appTheme.iconTheme
                                      .copyWith(color: appTheme.primaryColor)),
                              child: BlocConsumer<CustodianStatusListCubit,
                                      CustodianStatusListState>(
                                  listener: BlocHelper.defaultBlocListener(
                                      listener: (context, custodianState) {}),
                                  builder: (context, custodianState) {
                                    return BlocConsumer<MainDashboardCubit,
                                        MainDashboardState>(
                                      listener: BlocHelper.defaultBlocListener(
                                          listener:
                                              (context, dashboardState) {}),
                                      builder: (context, dashboardState) {
                                        final isCustodianNotEmpty = context
                                            .read<CustodianStatusListCubit>()
                                            .statutes
                                            .isNotEmpty;
                                        if (dashboardState
                                            is MainDashboardNetWorthLoaded) {
                                          final isAssetsNotEmpty =
                                              dashboardState.netWorthObj.assets
                                                      .currentValue !=
                                                  0;
                                          final isLiabilityNotEmpty =
                                              dashboardState
                                                      .netWorthObj
                                                      .liabilities
                                                      .currentValue !=
                                                  0;

                                          if (isAssetsNotEmpty ||
                                              isCustodianNotEmpty ||
                                              isLiabilityNotEmpty) {
                                            const Key tableKey =
                                                Key("tableKey");
                                            return Column(
                                              children: [
                                                const PrivacyBlurWarning(),
                                                const FilterAddPart(),
                                                const SizedBox(height: 12),
                                                BanksAuthorizationProcess(
                                                    initiallyExpanded: widget
                                                            .expandCustodian ||
                                                        !(isAssetsNotEmpty ||
                                                            isLiabilityNotEmpty)),
                                                if (isAssetsNotEmpty ||
                                                    isLiabilityNotEmpty)
                                                  SummeryWidget(
                                                      netWorthEntity:
                                                          dashboardState
                                                              .netWorthObj),
                                                const NetWorthBaseChart(),
                                                const SizedBox(height: 8),
                                                if ((twoFactorState
                                                            is TwoFactorLoaded &&
                                                        twoFactorState.entity
                                                                .twoFactorEnabled ==
                                                            false) &&
                                                    showTwoFactorReccoment)
                                                  TwoFactorRecommendationWidget(
                                                    onClose: () {
                                                      setState(() {
                                                        showTwoFactorReccoment =
                                                            false;
                                                      });
                                                    },
                                                  ),
                                                const SizedBox(height: 8),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text(
                                                      appLocalizations
                                                          .home_label_yourAssets,
                                                      style:
                                                          textTheme.titleLarge),
                                                ),
                                                RowOrColumn(
                                                  rowCrossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  showRow: !isMobile,
                                                  children: [
                                                    ExpandedIf(
                                                        expanded: !isMobile,
                                                        child:
                                                            const PieChartSample2()),
                                                    ExpandedIf(
                                                        expanded: !isMobile,
                                                        child:
                                                            const RandomWorldMapGenrator()),
                                                  ],
                                                ),
                                                Column(
                                                  key: tableKey,
                                                  children: [
                                                    const PerformanceAssetClassWidget(),
                                                    const PerformanceBenchmarkWidget(),
                                                    const PerformanceCustodianWidget(),
                                                  ]
                                                      .map((e) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8),
                                                            child: e,
                                                          ))
                                                      .toList(),
                                                ),
                                                const SizedBox(height: 8),
                                              ]
                                                  .map((e) => e.key == tableKey
                                                      ? e
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      16),
                                                          child: e))
                                                  .toList(),
                                            );
                                          }
                                          return const DashboardPage();
                                        }
                                        return const MainDashboardShimmer();
                                      },
                                    );
                                  })),
                        ),
                      ),
                    )
                  : WidthLimiterWidget(
                      width: 700,
                      child: Center(
                          child: SingleChildScrollView(
                              child: Theme(
                                  data: appTheme.copyWith(
                                      outlinedButtonTheme:
                                          OutlinedButtonThemeData(
                                        style: appTheme
                                            .outlinedButtonTheme.style!
                                            .copyWith(
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(0, 48))),
                                      ),
                                      elevatedButtonTheme:
                                          ElevatedButtonThemeData(
                                        style: appTheme
                                            .outlinedButtonTheme.style!
                                            .copyWith(
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(0, 48))),
                                      ),
                                      iconTheme: appTheme.iconTheme.copyWith(
                                          color: appTheme.primaryColor)),
                                  child: const DashboardPage()))))
              : const SingleChildScrollView(child: MainDashboardShimmer());
        },
      ),
    );
  }
}
