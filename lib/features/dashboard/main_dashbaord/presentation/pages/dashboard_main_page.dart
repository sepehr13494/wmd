import 'dart:developer';

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
import 'package:wmd/features/dashboard/main_dashbaord/presentation/charts_height_inherited.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/charts_height_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/main_dashboard_shimmer.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/dashboard_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/filter_add_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/net_worth_base_chart.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/summery_widget.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/entities/get_mandate_status_entity.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_asset_class_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_benchmark_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_custodian_widget.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/two_factor_recommendation_widget.dart';
import 'package:wmd/injection_container.dart';
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
  bool showTwoFactorReccoment = true;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    final appTheme = Theme.of(context);

    // final twoFactorState = context.read<TwoFactorCubit>().state;

    if (widget.expandCustodian) {
      context.read<CustodianStatusListCubit>().getCustodianStatusList();
      context.read<UserStatusCubit>().getUserStatus();
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
                              child: BlocProvider(
                                create: (context) => sl<MandateStatusCubit>()
                                  ..getMandateStatus(),
                                child: BlocConsumer<MandateStatusCubit,
                                        MandateStatusState>(
                                    listener: BlocHelper.defaultBlocListener(
                                        listener: (context, mandateState) {}),
                                    builder: (context, mandateState) {
                                      List<GetMandateStatusEntity> mandateList =
                                          [];
                                      if (mandateState
                                          is GetMandateStatusLoaded) {
                                        mandateList = List.from(mandateState
                                            .getMandateStatusEntities);
                                      }
                                      return BlocConsumer<
                                              CustodianStatusListCubit,
                                              CustodianStatusListState>(
                                          listener:
                                              BlocHelper.defaultBlocListener(
                                                  listener: (context,
                                                      custodianState) {}),
                                          builder: (context, custodianState) {
                                            return BlocConsumer<
                                                MainDashboardCubit,
                                                MainDashboardState>(
                                              listener: BlocHelper
                                                  .defaultBlocListener(
                                                      listener: (context,
                                                          dashboardState) {}),
                                              builder:
                                                  (context, dashboardState) {
                                                final isCustodianNotEmpty = context
                                                        .read<
                                                            CustodianStatusListCubit>()
                                                        .statutes
                                                        .isNotEmpty ||
                                                    mandateList.isNotEmpty;
                                                if (dashboardState
                                                    is MainDashboardNetWorthLoaded) {
                                                  final isAssetsNotEmpty =
                                                      dashboardState
                                                              .netWorthObj
                                                              .assets
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
                                                        const SizedBox(
                                                            height: 12),
                                                        BanksAuthorizationProcess(
                                                          initiallyExpanded: widget
                                                                  .expandCustodian ||
                                                              (!isAssetsNotEmpty &&
                                                                  !isLiabilityNotEmpty),
                                                          mandateList:
                                                              mandateList,
                                                        ),
                                                        if (isAssetsNotEmpty ||
                                                            isLiabilityNotEmpty)
                                                          SummeryWidget(
                                                              netWorthEntity:
                                                                  dashboardState
                                                                      .netWorthObj),
                                                        const NetWorthBaseChart(),
                                                        const SizedBox(
                                                            height: 8),
                                                        if ((state.userStatus
                                                                    .mobileNumberVerified ==
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
                                                        const SizedBox(
                                                            height: 8),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .centerStart,
                                                          child: Text(
                                                              appLocalizations
                                                                  .home_label_yourAssets,
                                                              style: textTheme
                                                                  .titleLarge),
                                                        ),
                                                        Center(
                                                          child: BlocProvider(
                                                            create: (context) =>
                                                                sl<ChartsHeightCubit>(),
                                                            child: BlocConsumer<
                                                                    ChartsHeightCubit,
                                                                    NewChartsHeight>(
                                                                listener: BlocHelper
                                                                    .defaultBlocListener(
                                                                        listener:
                                                                            (context,
                                                                                state) {}),
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  return ChartsChildrenCounts(
                                                                    length: state
                                                                        .length,
                                                                    child:
                                                                        RowOrColumn(
                                                                      rowCrossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      showRow:
                                                                          !isMobile,
                                                                      children: [
                                                                        ExpandedIf(
                                                                            expanded:
                                                                                !isMobile,
                                                                            child:
                                                                                const PieChartSample2()),
                                                                        ExpandedIf(
                                                                            expanded:
                                                                                !isMobile,
                                                                            child:
                                                                                const RandomWorldMapGenrator()),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                        Column(
                                                          key: tableKey,
                                                          children: [
                                                            const PerformanceAssetClassWidget(),
                                                            const PerformanceBenchmarkWidget(),
                                                            const PerformanceCustodianWidget(),
                                                          ]
                                                              .map(
                                                                  (e) =>
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 8),
                                                                        child:
                                                                            e,
                                                                      ))
                                                              .toList(),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                      ]
                                                          .map((e) => e.key ==
                                                                  tableKey
                                                              ? e
                                                              : Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8,
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
                                          });
                                    }),
                              )),
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
