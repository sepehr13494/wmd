import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/timer_widget.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class VerifyEmailPage extends AppStatelessWidget {
  final Map<String, dynamic> verifyMap;
  const VerifyEmailPage({Key? key, required this.verifyMap}) : super(key: key);

  bool _isForgotPasswordPage() {
    return verifyMap["forgotPassword"] == "true";
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);

    return BlocProvider(
      create: (context) {
        return sl<LoginSignUpCubit>();
      },
      child: Scaffold(
        appBar: const CustomAuthAppBar(automaticallyImplyLeading: false),
        body: WidthLimiterWidget(
            child: BlocConsumer<LoginSignUpCubit, LoginSignUpState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
            if (state is SuccessState) {
              GlobalFunctions.showSnackBar(context, 'Email verification sent',
                  type: "success");
            }
          }),
          builder: (context, state) {
            return Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textTheme.bodySmall!.color!.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                ),
                Text(
                  _isForgotPasswordPage()
                      ? appLocalizations.auth_forgot_emailSentSuccess_heading
                      : appLocalizations.auth_verifyResponse_page_description,
                  style: textTheme.headlineSmall,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsiveHelper.optimalDeviceWidth * 0.07),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: _isForgotPasswordPage()
                        ? TextSpan(children: [
                            TextSpan(
                              text: appLocalizations
                                  .auth_forgot_emailSentSuccess_subheading
                                  .replaceFirst("%s", verifyMap["email"]),
                              style: textTheme.bodyMedium!.copyWith(
                                height: 1.3,
                              ),
                            ),
                          ])
                        : TextSpan(children: [
                            TextSpan(
                              text: appLocalizations.auth_verify_description
                                  .replaceFirst("%s", ""),
                              style:
                                  textTheme.bodyMedium!.copyWith(height: 1.3),
                            ),
                            TextSpan(
                              text: verifyMap["email"],
                              style:
                                  textTheme.titleSmall!.copyWith(height: 1.3),
                            ),
                          ]),
                  ),
                ),
                const SizedBox(),
                TimerWidget(
                    sendCodeAgain: () {
                      context.read<LoginSignUpCubit>().resendEmail();
                    },
                    timerTime: _isForgotPasswordPage() ? 300 : 10,
                    isForgotPasswordPage: _isForgotPasswordPage()),
                const Spacer(),
                const Divider(),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(height: 1.3),
                        children: _isForgotPasswordPage()
                            ? [
                                TextSpan(
                                  text: appLocalizations
                                      .auth_forgot_link_backToLogin,
                                  style:
                                      textTheme.bodySmall!.toLinkStyle(context),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.goNamed(AppRoutes.login);
                                    },
                                )
                              ]
                            : [
                                TextSpan(
                                    text:
                                        "${appLocalizations.auth_verify_text_alreadyVerified} ",
                                    style: textTheme.bodySmall),
                                TextSpan(
                                  text: appLocalizations.auth_verify_link_login,
                                  style:
                                      textTheme.bodySmall!.toLinkStyle(context),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.goNamed(AppRoutes.login);
                                    },
                                ),
                              ])),
                const SizedBox(height: 24)
              ]
                  .map((e) => e is Spacer
                      ? e
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: e,
                        ))
                  .toList(),
            );
          },
        )),
      ),
    );
  }
}
