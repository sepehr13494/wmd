import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/page/add_bank_auto_page.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/pages/add_bank_manual_page.dart';
import 'package:wmd/features/add_assets/add_listed_security/presentation/pages/add_listed_security_page.dart';
import 'package:wmd/features/add_assets/add_loan_liability/presentation/pages/add_loan_liability_page.dart';
import 'package:wmd/features/add_assets/add_other_asset/presentation/pages/add_other_asset_page.dart';
import 'package:wmd/features/add_assets/add_private_debt/presentation/pages/add_private_debt_page.dart';
import 'package:wmd/features/add_assets/add_private_equity/presentation/pages/add_private_equity_page.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/pages/add_real_estate_page.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/pages/assets_list_view_page.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/pages/auto_manual_page.dart';
import 'package:wmd/features/asset_detail/core/presentation/pages/asset_detail_page.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
import 'package:wmd/features/authentication/forget_password/presentation/pages/forget_password_page.dart';
import 'package:wmd/features/authentication/forget_password/presentation/pages/reset_password_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/login_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/register_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/verify_email_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/welcome_page.dart';
import 'package:wmd/features/authentication/verify_email/presentation/pages/verify_response_page.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/pages/onboarding_page.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/help/support/presentation/pages/schedule_call_page.dart';
import 'package:wmd/features/help/support/presentation/pages/support_page.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';
import 'package:wmd/features/main_page/presentation/pages/main_page.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/features/profile/verify_phone/presentation/pages/verify_phone_number_page.dart';
import 'package:wmd/features/splash/presentation/pages/splash_page.dart';
import 'package:wmd/features/profile/core/presentation/pages/profile_page.dart';
import 'package:wmd/injection_container.dart';

import '../widgets/local_auth_wrapper.dart';

class AppRouter {
  AppRouter._privateConstructor();

  static final AppRouter _instance = AppRouter._privateConstructor();

  factory AppRouter() {
    return _instance;
  }

  UserStatusCubit _userStatusCubit = sl<UserStatusCubit>();
  MainDashboardCubit _mainDashboardCubit = sl<MainDashboardCubit>();
  SummeryWidgetCubit _summeryWidgetCubit = sl<SummeryWidgetCubit>();
  AssetsOverviewCubit _assetsOverviewCubit = sl<AssetsOverviewCubit>();
  ChartsCubit _chartsCubit = sl<ChartsCubit>();
  CurrencyChartCubit _currencyChartCubit = sl<CurrencyChartCubit>();
  AssetsGeographyChartCubit _assetsGeographyChartCubit = sl<AssetsGeographyChartCubit>();
  DashboardAllocationCubit _dashboardAllocationCubit =
      sl<DashboardAllocationCubit>();
  DashboardPieCubit _dashboardPieCubit = sl<DashboardPieCubit>();
  DashboardGoeCubit _dashboardGoeCubit = sl<DashboardGoeCubit>();
  CustodianStatusListCubit _custodianStatusListCubit =
      sl<CustodianStatusListCubit>();
  PersonalInformationCubit _personalInformationCubit =
      sl<PersonalInformationCubit>();

  GoRouter router() {
    return GoRouter(
      observers: [
        DatadogNavigationObserver(datadogSdk: DatadogSdk.instance),
      ],
      routes: <GoRoute>[
        GoRoute(
          name: AppRoutes.splash,
          path: "/",
          builder: (BuildContext context, GoRouterState state) {
            return const SplashPage();
          },
        ),
        GoRoute(
          name: AppRoutes.resetPassword,
          path: "/password/update",
          builder: (BuildContext context, GoRouterState state) {
            return ResetPasswordPage(verifyMap: state.queryParams);
          },
        ),
        GoRoute(
            name: AppRoutes.welcome,
            path: "/welcome",
            builder: (BuildContext context, GoRouterState state) {
              return const WelcomePage();
            },
            routes: [
              GoRoute(
                name: AppRoutes.login,
                path: "login",
                builder: (BuildContext context, GoRouterState state) {
                  return const LoginPage();
                },
              ),
              GoRoute(
                name: AppRoutes.register,
                path: "register",
                builder: (BuildContext context, GoRouterState state) {
                  return const RegisterPage();
                },
              ),
              GoRoute(
                name: AppRoutes.verifyEmail,
                path: "verify_email",
                builder: (BuildContext context, GoRouterState state) {
                  return VerifyEmailPage(verifyMap: state.queryParams);
                },
              ),
              GoRoute(
                name: AppRoutes.forgetPassword,
                path: "forget_password",
                builder: (BuildContext context, GoRouterState state) {
                  return const ForgetPasswordPage();
                },
              ),
            ]),
        GoRoute(
          path: "/verify-response",
          builder: (BuildContext context, GoRouterState state) {
            return VerifyResponsePage(verifyMap: state.queryParams);
          },
        ),
        GoRoute(
          name: AppRoutes.onboarding,
          path: "/onboarding",
          builder: (BuildContext context, GoRouterState state) {
            return const OnBoardingPage();
          },
        ),
        GoRoute(
            name: AppRoutes.main,
            path: "/main",
            builder: (BuildContext context, GoRouterState state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => sl<ChartChooserManager>()),
                  BlocProvider(create: (context) => sl<TabManager>()),
                  BlocProvider(create: (context) => sl<MainPageCubit>()),
                  BlocProvider(create: (context) {
                    _userStatusCubit = sl<UserStatusCubit>();
                    return _userStatusCubit;
                  }),
                  BlocProvider(create: (context) {
                    _mainDashboardCubit = sl<MainDashboardCubit>();
                    return _mainDashboardCubit..initPage();
                  }),
                  BlocProvider(create: (context) {
                    _summeryWidgetCubit = sl<SummeryWidgetCubit>();
                    return _summeryWidgetCubit..initPage();
                  }),
                  BlocProvider(create: (context) {
                    _assetsOverviewCubit = sl<AssetsOverviewCubit>();
                    return _assetsOverviewCubit..getAssetsOverview();
                  }),
                  BlocProvider(
                    create: (context) {
                      _chartsCubit = sl<ChartsCubit>();
                      return _chartsCubit..getChart();
                    },
                  ),
                  BlocProvider(
                    create: (context) {
                      _currencyChartCubit = sl<CurrencyChartCubit>();
                      return _currencyChartCubit..getCurrency();
                    },
                  ),
                  BlocProvider(
                    create: (context) {
                      _assetsGeographyChartCubit = sl<AssetsGeographyChartCubit>();
                      return _assetsGeographyChartCubit..getAssetsGeography();
                    },
                  ),
                  BlocProvider(
                    create: (context) {
                      _dashboardAllocationCubit =
                          sl<DashboardAllocationCubit>();
                      return _dashboardAllocationCubit..getAllocation();
                    },
                  ),
                  BlocProvider(
                    create: (context) {
                      _dashboardPieCubit = sl<DashboardPieCubit>();
                      return _dashboardPieCubit..getPie();
                    },
                  ),
                  BlocProvider(
                    create: (context) {
                      _dashboardGoeCubit = sl<DashboardGoeCubit>();
                      return _dashboardGoeCubit..getGeographic();
                    },
                  ),
                  BlocProvider(
                    create: (context) {
                      _custodianStatusListCubit =
                          sl<CustodianStatusListCubit>();
                      return _custodianStatusListCubit
                        ..getCustodianStatusList();
                    },
                  ),
                  BlocProvider(
                    lazy: false,
                    create: (context) {
                      _personalInformationCubit =
                          sl<PersonalInformationCubit>();
                      return _personalInformationCubit..getName();
                    },
                  ),
                ],
                child: LocalAuthWrapper(
                    child: MainPage(
                        expandCustodian:
                            state.queryParams['expandCustodian'] != null
                                ? state.queryParams['expandCustodian'] == 'true'
                                : false)),
              );
            },
            routes: [
              GoRoute(
                name: AppRoutes.assetDetailPage,
                path: "asset_detail",
                builder: (BuildContext context, GoRouterState state) {
                  return BlocProvider.value(
                    value: _mainDashboardCubit,
                    child: AssetDetailPage(
                      assetId: state.queryParams['assetId'] as String,
                      type: state.queryParams['type'] as String,
                    ),
                  );
                },
              ),
              GoRoute(
                  name: AppRoutes.settings,
                  path: "settings",
                  builder: (BuildContext context, GoRouterState state) {
                    return BlocProvider.value(
                      value: _personalInformationCubit..getName(),
                      child: const ProfilePage(),
                    );
                  },
                  routes: [
                    GoRoute(
                      name: AppRoutes.verifyPhone,
                      path: "verify-phone",
                      builder: (BuildContext context, GoRouterState state) {
                        return const VerifyPhoneNumberPage();
                      },
                    ),
                  ]),
              GoRoute(
                name: AppRoutes.support,
                path: "support",
                builder: (BuildContext context, GoRouterState state) {
                  return const SupportPage();
                },
              ),
              GoRoute(
                name: AppRoutes.scheduleCall,
                path: "schedule-meeting",
                builder: (BuildContext context, GoRouterState state) {
                  return BlocProvider.value(
                    value: _personalInformationCubit,
                    child: const ScheduleCallPage(),
                  );
                },
              ),
              GoRoute(
                name: AppRoutes.addAssetsView,
                path: "add_assets_view",
                builder: (BuildContext context, GoRouterState state) {
                  return BlocProvider.value(
                    value: _personalInformationCubit,
                    child: const AssetsListViewPage(),
                  );
                },
                routes: [
                  GoRoute(
                    name: AppRoutes.autoManualPage,
                    path: "auto_manual",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AutoManualPage();
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.addBankManualPage,
                    path: "add_manual_bank",
                    builder: (BuildContext context, GoRouterState state) {
                      return addAssetMainBlocProvider(
                          child: const AddBankManualPage());
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.addBankAutoPage,
                    path: "add_auto_bank",
                    builder: (BuildContext context, GoRouterState state) {
                      return addAssetMainBlocProvider(
                          child: const AddBankAutoPage());
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.addPrivateEquity,
                    path: "add_private_equity",
                    builder: (BuildContext context, GoRouterState state) {
                      return addAssetMainBlocProvider(
                          child: const AddPrivateEquityPage());
                    },
                  ),
                  GoRoute(
                      name: AppRoutes.addPrivateDebt,
                      path: "add_private_debt",
                      builder: (BuildContext context, GoRouterState state) {
                        return addAssetMainBlocProvider(
                            child: const AddPrivateDebtPage());
                      }),
                  GoRoute(
                      name: AppRoutes.addRealEstate,
                      path: "add_real_estate",
                      builder: (BuildContext context, GoRouterState state) {
                        return addAssetMainBlocProvider(
                            child: const AddRealEstatePage());
                      }),
                  GoRoute(
                      name: AppRoutes.addOther,
                      path: "add_other",
                      builder: (BuildContext context, GoRouterState state) {
                        return addAssetMainBlocProvider(
                            child: const AddOtherAssetPage());
                      }),
                  GoRoute(
                      name: AppRoutes.addListedAsset,
                      path: "add_listed_asset",
                      builder: (BuildContext context, GoRouterState state) {
                        return addAssetMainBlocProvider(
                            child: const AddListedSecurityPage());
                      }),
                  GoRoute(
                      name: AppRoutes.addLiability,
                      path: "add_liability",
                      builder: (BuildContext context, GoRouterState state) {
                        return addAssetMainBlocProvider(
                            child: const AddLoanLiabilityPage());
                      }),
                ],
              ),
            ]),
      ],
    );
  }

  Widget addAssetMainBlocProvider({required Widget child}) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(
        value: _mainDashboardCubit,
      ),
      BlocProvider.value(
        value: _summeryWidgetCubit,
      ),
      BlocProvider.value(
        value: _assetsOverviewCubit,
      ),
      BlocProvider.value(
        value: _chartsCubit,
      ),
      BlocProvider.value(
        value: _currencyChartCubit,
      ),
      BlocProvider.value(
        value: _assetsGeographyChartCubit,
      ),
      BlocProvider.value(
        value: _dashboardAllocationCubit,
      ),
      BlocProvider.value(
        value: _dashboardPieCubit,
      ),
      BlocProvider.value(
        value: _dashboardGoeCubit,
      ),
      BlocProvider.value(
        value: _custodianStatusListCubit,
      ),
    ], child: child);
  }
}
