import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wmd/core/presentation/routes/app_router.gr.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/injection_container.dart';

import 'navigation/url_strategy/url_strategy.dart';
import 'package:wmd/injection_container.dart' as di;

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
    final router = sl<AppRouter>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeManager()),
        BlocProvider(create: (context) => LocalizationManager()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          /*navigatorObservers: [
            SentryNavigatorObserver(),
          ],*/
          routerDelegate: AutoRouterDelegate(router),
          routeInformationParser: router.defaultRouteParser(),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title = "title"});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  AppState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends AppState<MyHomePage> {
  final int _counter = 0;

  void _incrementCounter() {
    if (context.read<ThemeManager>().state == ThemeMode.dark) {
      context.read<ThemeManager>().changeTheme(ThemeMode.light);
    } else {
      context.read<ThemeManager>().changeTheme(ThemeMode.dark);
    }
  }



  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme, AppLocalizations appLocalizations) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          DropdownButton(
              items: AppLocalizations.supportedLocales
                  .map((e) => DropdownMenuItem(value: e,child: Text(e.languageCode),)).toList(),
              onChanged: (val) {
                if(val != null){
                  context.read<LocalizationManager>().changeLang(val);
                }
              },hint: const Icon(Icons.language)),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              appLocalizations.incentive,
            ),
            Text(
              '$_counter',
              style: textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
