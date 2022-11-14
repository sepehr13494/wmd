import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/pages/add_bank_manual_page.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/pages/assets_list_view_page.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/pages/auto_manual_page.dart';
import 'package:wmd/features/authentication/forget_password/presentation/pages/forget_password_page.dart';
import 'package:wmd/features/authentication/forget_password/presentation/pages/reset_password_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/login_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/register_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/verify_email_page.dart';
import 'package:wmd/features/authentication/login_signup/presentation/pages/welcome_page.dart';
import 'package:wmd/features/authentication/verify_email/presentation/pages/verify_response_page.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/dashboard_page.dart';
import 'package:wmd/features/main_page/presentation/pages/main_page.dart';
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
                return VerifyEmailPage(verifyMap: state.queryParams);
              },
            ),
            GoRoute(
              name: AppRoutes.forgetPassword,
              path: "forget_password",
              builder: (BuildContext context, GoRouterState state) {
                return const ForgetPasswordPage();
              },
            ),
            GoRoute(
              name: AppRoutes.resetPassword,
              path: "reset_password",
              builder: (BuildContext context, GoRouterState state) {
                return ResetPasswordPage(verifyMap: state.queryParams);
              },
            ),
          ]),
      GoRoute(
        path: "/verify-response",
        builder: (BuildContext context, GoRouterState state) {
          return VerifyResponsePage(verifyMap: state.queryParams);
        },
      ),
      GoRoute(
          name: AppRoutes.main,
          path: "/main",
          builder: (context, state) {
            return const MainPage();
          },
          routes: [
            GoRoute(
                name: AppRoutes.addAssetsView,
                path: "add_assets_view",
                builder: (BuildContext context, GoRouterState state) {
                  return const AssetsListViewPage();
                },
                routes: [
                  GoRoute(
                    name: AppRoutes.autoManualPage,
                    path: "auto_manual",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AutoManualPage();
                    },
                  ),
                  GoRoute(
                    name: AppRoutes.addBankManualPage,
                    path: "add_manual_bank",
                    builder: (BuildContext context, GoRouterState state) {
                      return const AddBankManualPage();
                    },
                  ),
                ]),
          ])
    ],
  );
}
