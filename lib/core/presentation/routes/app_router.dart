import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:wmd/features/authentication/presentation/pages/login_page.dart';
import 'package:wmd/features/authentication/presentation/pages/register_page.dart';
import 'package:wmd/features/main/presentation/pages/main_page.dart';
import 'package:wmd/features/splash/presentation/pages/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: MainPage)
  ],
)
class $AppRouter {}

class EmptyRouterPage extends StatelessWidget {
  const EmptyRouterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

