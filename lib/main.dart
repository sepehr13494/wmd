import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();

  const String envFor = String.fromEnvironment(
    'env',
    defaultValue: 'dev',
  );
  final envFile = envInitConfig(envFor);
  await dotenv.load(fileName: envFile);
  await Hive.initFlutter();
  await di.init();

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
    runApp(const MyApp());
  });
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
    final router = AppRouter().router();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                sl<ThemeManager>()..changeTheme(sl<LocalStorage>().getTheme())),
        BlocProvider(
            create: (context) => sl<LocalizationManager>()
              ..changeLang(sl<LocalStorage>().getLocale())),
        BlocProvider(create: (context) => sl<LocalAuthManager>()),
      ],
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: MaterialApp.router(
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
          ),
        );
      }),
    );
  }
}
