import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/util/constants.dart';
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
import 'package:wmd/features/asset_detail/core/data/models/get_summary_params.dart';
import 'package:wmd/features/asset_detail/core/presentation/manager/asset_summary_cubit.dart';
import 'package:wmd/features/asset_detail/core/presentation/pages/asset_detail_page.dart';
import 'package:wmd/features/asset_see_more/bank_account/data/model/bank_account_more_entity.dart';
import 'package:wmd/features/asset_see_more/listed_asset/data/models/listed_asset_more_entity.dart';
import 'package:wmd/features/asset_see_more/other_asset/data/model/other_asset_more_entity.dart';
import 'package:wmd/features/asset_see_more/private_debt/data/models/private_debt_more_entity.dart';
import 'package:wmd/features/asset_see_more/private_equity/data/models/private_equity_more_entity.dart';
import 'package:wmd/features/asset_see_more/real_estate/data/model/real_estate_more_entity.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/presentation/manager/portfolio_tab_cubit.dart';
import 'package:wmd/features/authentication/forget_password/presentation/pages/forget_password_page.dart';
import 'package:wmd/features/authentication/forget_password/presentation/pages/reset_password_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/auth_checker_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/login_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/register_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/verify_email_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/welcome_page.dart';
import 'package:wmd/features/authentication/verify_email/presentation/pages/verify_response_page.dart';
import 'package:wmd/features/blurred_widget/presentation/manager/blurred_privacy_cubit.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/pages/onboarding_page.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/presentation/manager/client_index_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/force_update/presentation/pages/force_update_page.dart';
import 'package:wmd/features/glossary/presentation/pages/glossary_page.dart';
import 'package:wmd/features/help/support/presentation/pages/schedule_call_page.dart';
import 'package:wmd/features/help/support/presentation/pages/support_page.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';
import 'package:wmd/features/main_page/presentation/pages/main_page.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/pages/two_factor_setup_page.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/pages/verify_otp_page.dart';
import 'package:wmd/features/profile/verify_phone/presentation/manager/verify_phone_cubit.dart';
import 'package:wmd/features/profile/verify_phone/presentation/pages/verify_phone_number_page.dart';
import 'package:wmd/features/safe_device/presentation/pages/unsafe_device_page.dart';
import 'package:wmd/features/settings/core/presentation/page/settings_page.dart';
import 'package:wmd/features/splash/presentation/pages/splash_page.dart';
import 'package:wmd/features/profile/core/presentation/pages/profile_page.dart';
import 'package:wmd/injection_container.dart';

import '../widgets/local_auth_wrapper.dart';

class DeveloperAppRouter {
  DeveloperAppRouter._privateConstructor();

  static final DeveloperAppRouter _instance = DeveloperAppRouter._privateConstructor();

  factory DeveloperAppRouter() {
    return _instance;
  }

  static GoRouter router = GoRouter(
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
        name: AppRoutes.forceUpdate,
        path: "/force_update",
        builder: (BuildContext context, GoRouterState state) {
          return const ForceUpdatePage();
        },
      ),
      GoRoute(
        name: AppRoutes.unsafe_device,
        path: "/unsafe_device",
        builder: (BuildContext context, GoRouterState state) {
          return const UnsafeDevicePage();
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
                routes: [
                  GoRoute(
                    name: AppRoutes.verifyOtp,
                    path: "verify-otp",
                    builder: (BuildContext context, GoRouterState state) {
                      return MultiBlocProvider(providers: [
                        BlocProvider(
                          create: (context) {
                            return sl<VerifyPhoneCubit>();
                          },
                        ),
                        BlocProvider(
                          create: (context) {
                            return sl<UserStatusCubit>();
                          },
                        ),
                      ], child: VerifyOtpPage(verifyMap: state.queryParams));
                    },
                  )
                ]),
            GoRoute(
              name: AppRoutes.authCheck,
              path: "auth-check",
              builder: (BuildContext context, GoRouterState state) {
                return const AuthCheckerPage();
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
            return PrivacyBlurWrapper(
              child: LocalAuthWrapper(
                  child: MainPage(
                      expandCustodian:
                      state.queryParams['expandCustodian'] != null
                          ? state.queryParams['expandCustodian'] ==
                          'true'
                          : false)),
            );
          },
          routes: [
            GoRoute(
                name: AppRoutes.glossary,
                path: "glossary",
                builder: (BuildContext context, GoRouterState state) {
                  return const GlossaryPage();
                }),
            GoRoute(
                name: AppRoutes.assetDetailPage,
                path: "asset_detail",
                builder: (BuildContext context, GoRouterState state) {
                  return MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (context) {
                          return sl<AssetSummaryCubit>()
                            ..getSummary(
                              GetSummaryParams(
                                  assetId:
                                  state.queryParams['assetId'] as String,
                                  days: 7),
                            );
                        }),
                      ],
                      child: PrivacyBlurWrapper(
                        child: AssetDetailPage(
                          assetId: state.queryParams['assetId'] as String,
                          type: state.queryParams['type'] as String,
                        ),
                      ));
                },
                routes: [
                  GoRoute(
                    name: AppRoutes.editRealEstate,
                    path: "edit_real_estate",
                    builder: (BuildContext context, GoRouterState state) {
                      return AddRealEstatePage(
                        edit: true,
                        moreEntity: state.extra as RealEstateMoreEntity,
                      );
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.editBankManual,
                    path: "edit_bank_manual",
                    builder: (BuildContext context, GoRouterState state) {
                      return AddBankManualPage(
                        edit: true,
                        moreEntity: state.extra as BankAccountMoreEntity,
                      );
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.editOtherAsset,
                    path: "edit_other_asset",
                    builder: (BuildContext context, GoRouterState state) {
                      return AddOtherAssetPage(
                        edit: true,
                        moreEntity: state.extra as OtherAseetMoreEntity,
                      );
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.editPrivateEquity,
                    path: "edit_Private_equity",
                    builder: (BuildContext context, GoRouterState state) {
                      return AddPrivateEquityPage(
                        edit: true,
                        moreEntity: state.extra as PrivateEquityMoreEntity,
                      );
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.editPrivateDebt,
                    path: "edit_Private_debt",
                    builder: (BuildContext context, GoRouterState state) {
                      return AddPrivateDebtPage(
                        edit: true,
                        moreEntity: state.extra as PrivateDebtMoreEntity,
                      );
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.editListedAsset,
                    path: "edit_listed_asset",
                    builder: (BuildContext context, GoRouterState state) {
                      return AddListedSecurityPage(
                        edit: true,
                        moreEntity: state.extra as ListedAssetMoreEntity,
                      );
                    },
                  ),
                ]),
            GoRoute(
                name: AppRoutes.settings,
                path: "settings",
                builder: (BuildContext context, GoRouterState state) {
                  return const PrivacyBlurWrapper(
                    child: SettingsPage(),
                  );
                },
                routes: [
                  GoRoute(
                    name: AppRoutes.verifyPhone,
                    path: "verify-phone",
                    builder: (BuildContext context, GoRouterState state) {
                      return VerifyPhoneNumberPage(
                          verifyMap: state.queryParams
                      );
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.twoFactorAuth,
                    path: "two-factor-auth",
                    builder: (BuildContext context, GoRouterState state) {
                      return const PrivacyBlurWrapper(
                        child: TwoFactorSetupPage(),
                      );
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
                return const ScheduleCallPage();
              },
            ),
            GoRoute(
              name: AppRoutes.addAssetsView,
              path: "add_assets_view",
              builder: (BuildContext context, GoRouterState state) {
                final t = state.queryParams['initial'];
                int? initial = t != null ? int.parse(t) : 0;
                return AssetsListViewPage(initial: initial);
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
                    return const AddBankManualPage();
                  },
                ),
                GoRoute(
                  name: AppRoutes.addBankAutoPage,
                  path: "add_auto_bank",
                  builder: (BuildContext context, GoRouterState state) {
                    return const AddBankAutoPage();
                  },
                ),
                GoRoute(
                  name: AppRoutes.addPrivateEquity,
                  path: "add_private_equity",
                  builder: (BuildContext context, GoRouterState state) {
                    return const AddPrivateEquityPage();
                  },
                ),
                GoRoute(
                    name: AppRoutes.addPrivateDebt,
                    path: "add_private_debt",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AddPrivateDebtPage();
                    }),
                GoRoute(
                    name: AppRoutes.addRealEstate,
                    path: "add_real_estate",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AddRealEstatePage();
                    }),
                GoRoute(
                    name: AppRoutes.addOther,
                    path: "add_other",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AddOtherAssetPage();
                    }),
                GoRoute(
                    name: AppRoutes.addListedAsset,
                    path: "add_listed_asset",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AddListedSecurityPage();
                    }),
                GoRoute(
                    name: AppRoutes.addLiability,
                    path: "add_liability",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AddLoanLiabilityPage();
                    }),
              ],
            ),
          ]),
    ],
  );
}
