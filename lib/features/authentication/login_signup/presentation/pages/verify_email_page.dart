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
import 'package:wmd/features/authentication/forget_password/presentation/manager/forget_password_cubit.dart';
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return sl<LoginSignUpCubit>();
        }),
        BlocProvider(create: (context) {
          return sl<ForgetPasswordCubit>();
        })
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAuthAppBar(automaticallyImplyLeading: false),
        body: WidthLimiterWidget(
            child: MultiBlocListener(
                listeners: [
              BlocListener<LoginSignUpCubit, LoginSignUpState>(
                listener:
                    BlocHelper.defaultBlocListener(listener: (context, state) {
                  if (state is SuccessState) {
                    GlobalFunctions.showSnackBar(context,
                        appLocalizations.auth_forgot_toast_success_title,
                        type: "success");
                  }
                }),
              ),
              BlocListener<ForgetPasswordCubit, BaseState>(
                listener:
                    BlocHelper.defaultBlocListener(listener: (context, state) {
                  if (state is SuccessState) {
                    GlobalFunctions.showSnackBar(context,
                        appLocalizations.auth_forgot_toast_success_title,
                        type: "success");
                  }
                }),
              ),
            ],
                child: Builder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            ? appLocalizations
                                .auth_forgot_emailSentSuccess_heading
                            : appLocalizations
                                .auth_verifyResponse_page_description,
                        style: textTheme.titleLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsiveHelper.optimalDeviceWidth *
                                (_isForgotPasswordPage() ? 0.1 : 0.11)),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: _isForgotPasswordPage()
                              ? TextSpan(children: [
                                  TextSpan(
                                    text:
                                        appLocalizations.auth_forgot_subheading,
                                    style: textTheme.bodyMedium!
                                        .copyWith(height: 1.3, fontSize: 14),
                                  ),
                                ])
                              : TextSpan(children: [
                                  TextSpan(
                                    text: appLocalizations
                                        .auth_verify_description_mobile
                                        .replaceFirst("%s", ""),
                                    style: textTheme.bodyMedium!
                                        .copyWith(height: 1.6, fontSize: 14),
                                  ),
                                  TextSpan(
                                    text: verifyMap["email"],
                                    style: textTheme.titleSmall!
                                        .copyWith(height: 1.3),
                                  ),
                                ]),
                        ),
                      ),
                      const SizedBox(),
                      TimerWidget(
                          sendCodeAgain: () {
                            if (_isForgotPasswordPage()) {
                              context
                                  .read<ForgetPasswordCubit>()
                                  .forgetPassword(map: {
                                "emailOrUserName": verifyMap["email"]
                              });
                            } else {
                              context.read<LoginSignUpCubit>().resendEmail();
                            }
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
                                        style: textTheme.bodyLarge!
                                            .toLinkStyle(context),
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
                                        text: appLocalizations
                                            .auth_verify_link_login,
                                        style: textTheme.bodySmall!
                                            .toLinkStyle(context),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.goNamed(AppRoutes.login);
                                          },
                                      ),
                                    ])),
                      const SizedBox(height: 20)
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
                }))),
      ),
    );
  }
}
