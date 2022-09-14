import 'package:auto_route/annotations.dart';
import 'package:wmd/features/splash/presentation/pages/splash_page.dart';
import 'package:wmd/main.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: MyHomePage),
  ],
)
class $AppRouter {}