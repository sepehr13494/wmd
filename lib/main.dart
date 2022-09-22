import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wmd/core/presentation/routes/app_router.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';

import 'package:wmd/injection_container.dart' as di;

import 'core/presentation/routes/url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeManager>()..changeTheme(sl<LocalStorage>().getTheme())),
        BlocProvider(create: (context) => sl<LocalizationManager>()..changeLang(sl<LocalStorage>().getLocale())),
      ],
      child: Builder(builder: (context) {
        
        return MaterialApp.router(
          /*navigatorObservers: [
            SentryNavigatorObserver(),
          ],*/
          routerConfig: router,
          title: 'WMD',
          theme: AppThemes.getAppTheme(context,brightness: Brightness.light),
          darkTheme: AppThemes.getAppTheme(context,brightness: Brightness.dark),
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
