import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/dashboard_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/filter_add_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/net_worth_base_chart.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/summery_widget.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';

import '../../../dashboard_charts/presentation/widgets/pie_chart_sample.dart';
import '../../../dashboard_charts/presentation/widgets/random_map.dart';
import '../widget/bank_auth_process.dart';
import 'dashboard_page.dart';

class DashboardMainPage extends StatefulWidget {
  const DashboardMainPage({Key? key}) : super(key: key);

  @override
  AppState<DashboardMainPage> createState() => _DashboardMainPageState();
}

class _DashboardMainPageState extends AppState<DashboardMainPage> {
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: const DashboardAppBar(),
      body: BlocConsumer<UserStatusCubit, UserStatusState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {
          if (state is UserStatusLoaded) {
            if (!(state.userStatus.emailVerified ?? true)) {
              context.goNamed(AppRoutes.verifyEmail,
                  queryParams: {"email": state.userStatus.email ?? ""});
            } else if (state.userStatus.loginAt == null) {
              context.goNamed(AppRoutes.onboarding);
            }
          }
        }),
        builder: (context, state) {
          return state is UserStatusLoaded
              ? (state.userStatus.loginAt != null)
                  ? WidthLimiterWidget(
                      width: 700,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Theme(
                            data: appTheme.copyWith(
                                outlinedButtonTheme: OutlinedButtonThemeData(
                                  style: appTheme.outlinedButtonTheme.style!
                                      .copyWith(
                                          minimumSize: MaterialStateProperty.all(
                                              const Size(0, 48))),
                                ),
                                elevatedButtonTheme: ElevatedButtonThemeData(
                                  style: appTheme.outlinedButtonTheme.style!
                                      .copyWith(
                                          minimumSize: MaterialStateProperty.all(
                                              const Size(0, 48))),
                                ),
                                iconTheme: appTheme.iconTheme
                                    .copyWith(color: appTheme.primaryColor)),
                            child: BlocConsumer<MainDashboardCubit,
                                MainDashboardState>(
                              listener: BlocHelper.defaultBlocListener(
                                  listener: (context, state) {}),
                              builder: (context, state) {
                                return state is MainDashboardNetWorthLoaded
                                    ? (state.netWorthObj.assets.currentValue !=
                                                0 ||
                                            state.netWorthObj.liabilities
                                                    .currentValue !=
                                                0)
                                        ? Column(
                                            children: [
                                              const FilterAddPart(),
                                              const SizedBox(height: 12),
                                              const BanksAuthorizationProcess(),
                                              SummeryWidget(
                                                  netWorthEntity:
                                                      state.netWorthObj),
                                              const NetWorthBaseChart(),
                                              RowOrColumn(
                                                rowCrossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                showRow: !isMobile,
                                                children: [
                                                  ExpandedIf(
                                                      expanded: !isMobile,
                                                      child:
                                                          RandomWorldMapGenrator()),
                                                  ExpandedIf(
                                                      expanded: !isMobile,
                                                      child:
                                                          const PieChartSample2()),
                                                ],
                                              ),
                                            ]
                                                .map((e) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                    child: e))
                                                .toList(),
                                          )
                                        : const DashboardPage()
                                    : LoadingWidget();
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  : const LoadingWidget()
              : const LoadingWidget();
        },
      ),
    );
  }
}
