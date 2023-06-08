import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wmd/core/presentation/routes/developer_app_router.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/presentation/manager/portfolio_tab_cubit.dart';
import 'package:wmd/features/blurred_widget/presentation/manager/blurred_privacy_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/presentation/manager/client_index_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/safe_device/presentation/pages/unsafe_device_page.dart';
import 'package:wmd/firebase_options.dart';
import 'core/presentation/routes/app_router.dart';
import 'core/util/app_localization.dart';
import 'core/util/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/util/local_storage.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'core/presentation/routes/url_strategy/url_strategy.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  const String envFor = String.fromEnvironment(
    'env',
    defaultValue: 'developer',
  );
  final envFile = envInitConfig(envFor);
  await dotenv.load(fileName: envFile);
  await Hive.initFlutter();
  await di.init(envFor);

  final configuration = DdSdkConfiguration(
    clientToken: 'pub8df6124a6a447c1cbdf885ffe962ac6d',
    env: 'dev',
    site: DatadogSite.eu1,
    trackingConsent: TrackingConsent.granted,
    nativeCrashReportEnabled: true,
    loggingConfiguration: LoggingConfiguration(),
    rumConfiguration:
        RumConfiguration(applicationId: '7cc0a75a-848f-47ee-b6e7-c54a9e9888c4'),
  );
  await DatadogSdk.runApp(configuration, () async {
    WidgetsFlutterBinding.ensureInitialized();
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    if (data.size.shortestSide < 600) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
    runApp(const MyApp());
  });
}

envInitConfig(env) {
  switch (env) {
    case "uat":
      return "assets/env/uat.env";
    case "qa":
      return "assets/env/qa.env";
    case "prod":
      return "assets/env/prod.env";
    case "dev":
      return "assets/env/.env";
    case "developer":
      return "assets/env/developer.env";
    default:
      return "assets/env/.env";
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late GoRouter router;
    if (AppConstants.developRoutes) {
      router = DeveloperAppRouter.router;
    } else {
      router = AppRouter().router();
    }
    bool isObsecured = false;
    final allProviders = [
      BlocProvider(
          create: (context) =>
              sl<ThemeManager>()..changeTheme(sl<LocalStorage>().getTheme())),
      BlocProvider(
          create: (context) => sl<LocalizationManager>()
            ..changeLang(sl<LocalStorage>().getLocale())),
      BlocProvider(create: (context) => sl<LocalAuthManager>()),
    ];
    if (AppConstants.developRoutes) {
      final developerProviders = [
        BlocProvider(create: (context) => sl<AssetChartChooserManager>()),
        BlocProvider(create: (context) => sl<GeoChartChooserManager>()),
        BlocProvider(
          create: (context) => sl<TabManager>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl<TabScrollManager>(),
        ),
        BlocProvider(create: (context) {
          return sl<MainPageCubit>();
        }),
        BlocProvider(create: (context) {
          return sl<UserStatusCubit>();
        }),
        BlocProvider(create: (context) {
          return sl<MainDashboardCubit>()..initPage();
        }),
        BlocProvider(create: (context) {
          return sl<BlurredPrivacyCubit>()..getIsBlurred();
        }),
        BlocProvider(create: (context) {
          return sl<SummeryWidgetCubit>()..initPage();
        }),
        BlocProvider(create: (context) {
          return sl<AssetsOverviewCubit>()..getAssetsOverview();
        }),
        BlocProvider(create: (context) {
          return sl<PerformanceAssetClassCubit>()..getAssetClass();
        }),
        BlocProvider(create: (context) {
          return sl<PerformanceBenchmarkCubit>()..getBenchmark();
        }),
        BlocProvider(create: (context) {
          return sl<ClientIndexCubit>()..getClientIndex();
        }),
        BlocProvider(create: (context) {
          return sl<PerformanceCustodianCubit>()..getCustodianPerformance();
        }),
        BlocProvider(
          create: (context) {
            return sl<ChartsCubit>()..getChart();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<CurrencyChartCubit>()..getCurrency();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<AssetsGeographyChartCubit>()..getAssetsGeography();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<PortfolioTabCubit>()..getPortfolioTab();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<DashboardAllocationCubit>()..getAllocation();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<DashboardPieCubit>()..getPie();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<DashboardGoeCubit>()..getGeographic();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<CustodianStatusListCubit>()..getCustodianStatusList();
          },
        ),
        BlocProvider(
          lazy: false,
          create: (context) {
            return sl<PersonalInformationCubit>()..getName();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<TwoFactorCubit>()..getTwoFactor();
          },
        ),
      ];
      allProviders.addAll(developerProviders);
    }
    return MultiBlocProvider(
      providers: allProviders,
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: VisibilityDetector(
              key: const Key('app-key'),
              onVisibilityChanged: (visibilityInfo) {
                debugPrint(
                    'Widget ${visibilityInfo.key} is ${visibilityInfo.visibleFraction}% visible');
                if (visibilityInfo.visibleFraction != 1.0) {
                  // Widget is obscured
                  isObsecured = true;
                }

                // chewieController?.pause();
              },
              child: isObsecured
                  ? const UnsafeDevicePage()
                  : MaterialApp.router(
                      routerConfig: router,
                      title: 'WMD',
                      theme: AppThemes.getAppTheme(context,
                          brightness: Brightness.light),
                      darkTheme: AppThemes.getAppTheme(context,
                          brightness: Brightness.dark),
                      themeMode: context.watch<ThemeManager>().state,
                      localizationsDelegates: const [
                        ...AppLocalizations.localizationsDelegates,
                        FormBuilderLocalizations.delegate,
                      ],
                      supportedLocales: AppLocalizations.supportedLocales,
                      locale: context.watch<LocalizationManager>().state,
                    )),
        );
      }),
    );
  }
}
