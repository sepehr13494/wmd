import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/resend_timer_widget.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/post_resend_verify_phone_usecase.dart';
import 'package:wmd/features/profile/verify_phone/presentation/manager/verify_phone_cubit.dart';
import 'package:wmd/features/profile/verify_phone/presentation/widgets/otp_feild_widget.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';
import 'package:go_router/go_router.dart';

class VerifyPhoneNumberPage extends StatefulWidget {
  final Map<String, dynamic> verifyMap;
  const VerifyPhoneNumberPage({Key? key, required this.verifyMap})
      : super(key: key);

  @override
  AppState<VerifyPhoneNumberPage> createState() =>
      _VerifyPhoneNumberPageState();
}

class _VerifyPhoneNumberPageState extends AppState<VerifyPhoneNumberPage> {
  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;
  bool _otpExpired = false;
  int failedAttampts = 0;
  bool showError = false;
  bool resetTimer = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    final responsiveHelper = ResponsiveHelper(context: context);

    return BlocProvider(
        create: (context) => sl<VerifyPhoneCubit>()
          ..postResendVerifyPhone(
              map: {"phoneNumber": widget.verifyMap['phoneNumber']}),
        child: BlocConsumer<VerifyPhoneCubit, VerifyPhoneState>(
            listener: (context, state) {
          if (state is SuccessState) {
            context.goNamed(AppRoutes.settings);
          } else if (state is ErrorState) {
            setState(() {
              showError = true;
            });
            GlobalFunctions.showSnackBar(
                context,
                AppLocalizations.of(context)
                    .profile_twofactorauthentication_onboarding_error_invalidOTP,
                color: Colors.red[800],
                type: "error");
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: const AddAssetHeader(
              title: "",
              considerFirstTime: false,
            ),
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
                                  child: const Icon(
                                    Icons.lock,
                                    color: AppColors.primary,
                                    size: 35,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  appLocalizations
                                      .profile_otpVerification_label_heading,
                                  style: textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  appLocalizations
                                      .profile_twofactorauthentication_page_mobileVerificationDescription,
                                  style: textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),

                        SizedBox(height: responsiveHelper.bigger24Gap),

                        SizedBox(height: responsiveHelper.defaultGap),
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
                              _otp = code;
                            });
                          },
                          clearText: showError || resetTimer,
                          enabled: !_otpExpired,
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) {
                            context
                                .read<VerifyPhoneCubit>()
                                .postVerifyPhone(map: {
                              // "identifier": state is VerifyOtpLoaded
                              //     ? state.entity.identifier
                              //     : "",
                              "identifier":
                                  sl<PostResendVerifyPhoneUseCase>().identifier,
                              "code": verificationCode
                            });
                          }, // end onSubmit
                        ),
                        SizedBox(height: responsiveHelper.defaultGap),
                        BasicTimerWidget(
                            timerTime: 600000,
                            handleOtpExpired: () {
                              setState(() {
                                _otpExpired = true;
                              });
                            }),
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
                                  context
                                      .read<VerifyPhoneCubit>()
                                      .postResendVerifyPhone(map: {
                                    "phoneNumber":
                                        widget.verifyMap['phoneNumber']
                                  });

                                  setState(() {
                                    showError = false;
                                    resetTimer = true;
                                  });
                                })
                          ],
                        ),

                        SizedBox(height: responsiveHelper.bigger24Gap),

                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(height: 1.3),
                                children: [
                              TextSpan(
                                text: appLocalizations
                                    .profile_otpVerification_button_back,
                                style:
                                    textTheme.bodyLarge!.toLinkStyle(context),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed(AppRoutes.settings);
                                  },
                              )
                            ])),
                        // Display the entered OTP code
                      ],
                    )))),
          );
        }));
  }
}

// Create an input widget that takes only one digit
