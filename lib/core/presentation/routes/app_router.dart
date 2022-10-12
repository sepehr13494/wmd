import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/presentation/pages/forget_password_page.dart';
import 'package:wmd/features/authentication/presentation/pages/login_page.dart';
import 'package:wmd/features/authentication/presentation/pages/register_page.dart';
import 'package:wmd/features/authentication/presentation/pages/verify_email_page.dart';
import 'package:wmd/features/authentication/presentation/pages/welcome_page.dart';
import 'package:wmd/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:wmd/features/main/presentation/pages/main_page.dart';
import 'package:wmd/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: AppRoutes.splash,
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
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
                return VerifyEmailPage(
                    registerParams: state.extra as RegisterParams);
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
        name: AppRoutes.dashboard,
        path: "/dashboard",
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardPage();
        },
      ),
    ],
  );
}
