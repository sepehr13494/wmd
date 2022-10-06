import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import '../../../../core/util/app_localization.dart';
import '../../../../core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/util/app_theme.dart';
import '../../../../core/util/local_storage.dart';
import '../../../../injection_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.title = "title"});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  AppState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends AppState<MainPage> {
  final int _counter = 0;

  Future<void> _incrementCounter() async {
    if (context.read<ThemeManager>().state == ThemeMode.dark) {
      context.read<ThemeManager>().changeTheme(ThemeMode.light);
      sl<LocalStorage>().setTheme(ThemeMode.light);
    } else {
      context.read<ThemeManager>().changeTheme(ThemeMode.dark);
      sl<LocalStorage>().setTheme(ThemeMode.dark);
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
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
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.languageCode),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  context.read<LocalizationManager>().changeLang(val);
                  sl<LocalStorage>().setLocale(val);
                }
              },
              hint: const Icon(Icons.language)),
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
        onPressed: (){
          sl<LocalStorage>().logout();
          context.go(AppRoutes.splash);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
