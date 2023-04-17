import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/basic_timer_widget.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/failed_otp_auth_bottom_sheet.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/resend_timer_widget.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/get_send_otp_usecase.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/post_resend_verify_phone_usecase.dart';
import 'package:wmd/features/profile/verify_phone/presentation/manager/verify_phone_cubit.dart';
import 'package:wmd/features/profile/verify_phone/presentation/widgets/otp_feild_widget.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpPage extends StatefulWidget {
  final Map<String, dynamic> verifyMap;
  const VerifyOtpPage({Key? key, required this.verifyMap}) : super(key: key);

  @override
  AppState<VerifyOtpPage> createState() => _VerifyPhoneNumberPageState();
}

class _VerifyPhoneNumberPageState extends AppState<VerifyOtpPage> {
  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;
  bool _otpExpired = false;
  int failedAttampts = 0;
  bool showError = false;
  bool showErrorInput = false;
  bool resetTimer = false;
  bool resetCode = false;
  int resendCodeCount = 0;

  @override
  void initState() {
    super.initState();

    context.read<VerifyPhoneCubit>().getSendOtp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    final responsiveHelper = ResponsiveHelper(context: context);

    final userStatus = context.watch<UserStatusCubit>().state;

    return BlocConsumer<VerifyPhoneCubit, VerifyPhoneState>(
        listener: (context, state) {
      if (userStatus is UserStatusLoaded) {
        if (userStatus.userStatus.optAttemptExceeded == true) {
          showModalBottomSheet(
              isDismissible: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return FailedOtpAuthBottomSheet(
                  callback: (() => context.goNamed(AppRoutes.login)),
                );
              });
        }
      }

      if (state is VerifyOtpLoaded && resendCodeCount != 0) {
        GlobalFunctions.showSnackBar(context, 'Verification code sent',
            type: "success");
      }
      if (state is SuccessState) {
        context.goNamed(AppRoutes.onboarding);
      } else if (state is ErrorState) {
        GlobalFunctions.showSnackBar(
            context,
            AppLocalizations.of(context)
                .profile_twofactorauthentication_onboarding_error_invalidOTP,
            color: Colors.red[800],
            type: "error");

        setState(() {
          showError = true;
          showErrorInput = true;
        });

        Timer(
            const Duration(seconds: 2),
            () => setState(() {
                  showErrorInput = false;
                }));

        if (failedAttampts >= 2) {
          showModalBottomSheet(
              isDismissible: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return FailedOtpAuthBottomSheet(
                  callback: (() => context.goNamed(AppRoutes.login)),
                );
              });
        }

        setState(() {
          failedAttampts = failedAttampts + 1;
        });
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: const CustomAuthAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Theme(
                data: Theme.of(context).copyWith(),
                child: WidthLimiterWidget(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.darkCardColorForDarkTheme,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: SvgPicture.asset(
                                "assets/images/lock_otp.svg",
                                height: 35,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              appLocalizations.auth_verifyOtp_title,
                              style: textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              appLocalizations.auth_verifyOtp_subTitle,
                              style: textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),

                    SizedBox(height: responsiveHelper.bigger24Gap),

                    OtpTextField(
                      numberOfFields: 6,
                      focusedBorderColor: AppColors.primary,
                      enabledBorderColor: showError
                          ? AppColors.errorColor
                          : AppColors.anotherCardColorForDarkTheme,
                      // borderColor: AppColors.anotherCardColorForDarkTheme,
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                        setState(() {
                          resetCode = false;
                        });
                      },
                      clearText: showErrorInput || resetTimer || resetCode,
                      enabled: !_otpExpired,
                      autoFocus: true,
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        context.read<VerifyPhoneCubit>().postVerifyPhone(map: {
                          "identifier": sl<GetSendOtpUseCase>().identifier,
                          "code": verificationCode
                        });
                      }, // end onSubmit
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            resetCode = true;
                          });
                        },
                        child: Text(
                          "Clear all",
                          style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.underline),
                        )),

                    SizedBox(height: responsiveHelper.defaultGap),
                    (showError
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              appLocalizations
                                  .profile_twofactorauthentication_onboarding_error_maximumAttempt
                                  .replaceFirst("{{attempt}}",
                                      (3 - failedAttampts).toString()),
                              style: textTheme.bodyMedium
                                  ?.apply(color: Colors.red[800]),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : BasicTimerWidget(
                            timerTime: 600000,
                            resetTime: resetTimer,
                            handleOtpExpired: () {
                              setState(() {
                                _otpExpired = true;
                              });
                            })),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(height: 1.3),
                                children: [
                              TextSpan(
                                text: appLocalizations
                                    .profile_otpVerification_text_verificationCodeNotReceived,
                                style: textTheme.bodyMedium,
                              ),
                            ])),
                        ResendTimerWidget(
                            timerTime: 10,
                            resetTime: resetTimer,
                            resetCallback: () {
                              setState(() {
                                resetTimer = false;
                              });
                            },
                            handleOtpExpired: () {
                              context.read<VerifyPhoneCubit>().getSendOtp();

                              setState(() {
                                showError = false;
                                showErrorInput = false;
                                resetTimer = true;
                                resendCodeCount = resendCodeCount + 1;
                              });

                              // ignore: invalid_use_of_protected_member
                              // Navigator.pop(context); // pop current page
                              // Navigator.pushNamed(context,
                              //     AppRoutes.verifyOtp); // push it back in
                            })
                      ],
                    ),

                    SizedBox(height: responsiveHelper.bigger24Gap),

                    const SizedBox(
                      height: 30,
                    ),
                    // const Spacer(),
                    const Divider(),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(height: 1.3),
                            children: [
                          TextSpan(
                            text: appLocalizations
                                .profile_twofactorauthentication_button_backToLogin,
                            style: textTheme.bodyLarge!.toLinkStyle(context),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.goNamed(AppRoutes.login);
                              },
                          )
                        ])),
                    // Display the entered OTP code
                  ],
                )))),
      );
    });
  }
}

// Create an input widget that takes only one digit
