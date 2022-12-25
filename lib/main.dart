import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'core/presentation/routes/app_router.dart';
import 'core/util/app_localization.dart';
import 'core/util/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/util/local_storage.dart';
import 'features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'injection_container.dart';

import 'injection_container.dart' as di;

import 'core/presentation/routes/url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  const String envFor = String.fromEnvironment(
    'env',
    defaultValue: 'dev',
  );
  final envFile = envInitConfig(envFor);
  await dotenv.load(fileName: envFile);
  await Hive.initFlutter();
  await di.init();
  /*await SentryFlutter.init(
        (options) {
      options.dsn = 'https://eb60042051a848d298dbeab291c89f03@o1020394.ingest.sentry.io/6740091';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );*/
  runApp(const MyApp());
}

envInitConfig(env) {
  switch (env) {
    case "uat":
      return "assets/env/uat.env";
    case "qa":
      return "assets/env/qa.env";
    case "dev":
      return "assets/env/.env";
    default:
      return "assets/env/.env";
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                sl<ThemeManager>()..changeTheme(sl<LocalStorage>().getTheme())),
        BlocProvider(
            create: (context) => sl<LocalizationManager>()
              ..changeLang(sl<LocalStorage>().getLocale())),
        BlocProvider(create: (context) => sl<UserStatusCubit>()),
        BlocProvider(
            create: (context) => sl<MainDashboardCubit>()..initPage()),
        BlocProvider(
            create: (context) =>
            sl<AssetsOverviewCubit>()..getAssetsOverview()),
        BlocProvider(
          create: (context) => sl<ChartsCubit>()..getChart(to: DateTime.now()),
        ),
        BlocProvider(
          create: (context) => sl<DashboardAllocationCubit>()
            ..getAllocation(dateTime: DateTime.now()),
        ),
        BlocProvider(
          create: (context) => sl<DashboardPieCubit>()..getPie(),
        ),
        BlocProvider(
          create: (context) => sl<DashboardGoeCubit>()..getGeographic(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          /*navigatorObservers: [
            SentryNavigatorObserver(),
          ],*/
          routerConfig: router,
          title: 'WMD',
          theme: AppThemes.getAppTheme(context, brightness: Brightness.light),
          darkTheme:
              AppThemes.getAppTheme(context, brightness: Brightness.dark),
          themeMode: context.watch<ThemeManager>().state,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            FormBuilderLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: context.watch<LocalizationManager>().state,
        );
      }),
    );
  }
}
