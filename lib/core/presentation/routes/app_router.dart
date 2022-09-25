import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/features/authentication/presentation/pages/login_page.dart';
import 'package:wmd/features/authentication/presentation/pages/register_page.dart';
import 'package:wmd/features/authentication/presentation/pages/verify_email_page.dart';
import 'package:wmd/features/authentication/presentation/pages/welcome_page.dart';
import 'package:wmd/features/main/presentation/pages/main_page.dart';
import 'package:wmd/features/splash/presentation/pages/splash_page.dart';

class AppRouter{
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        builder: (BuildContext context, GoRouterState state) {
          return const VerifyEmailPage();
        },
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (BuildContext context, GoRouterState state) {
          return const MainPage();
        },
      ),
    ],
  );
}