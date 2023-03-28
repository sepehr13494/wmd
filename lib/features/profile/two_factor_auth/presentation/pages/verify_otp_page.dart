import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/basic_timer_widget.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
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
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;
  bool _otpExpired = false;

  @override
  void initState() {
    super.initState();
    _fieldSix.addListener(() => _onTextChanged(context));

    context.read<VerifyPhoneCubit>().getSendOtp();
  }

  @override
  void dispose() {
    _fieldSix.dispose();
    super.dispose();
  }

  void _onTextChanged(BuildContext context) {
    if (_fieldSix.text != '') {
      // Fire an event when the input matches the condition
      // For example, you can use a callback function to handle the event
      final state = context.read<VerifyPhoneCubit>().state;

      final otpTemp = _fieldOne.text +
          _fieldTwo.text +
          _fieldThree.text +
          _fieldFour.text +
          _fieldFive.text +
          _fieldSix.text;

      context.read<VerifyPhoneCubit>().postVerifyPhone(map: {
        "identifier": sl<PostResendVerifyPhoneUseCase>().identifier,
        "code": otpTemp
      });
    }
  }

  void resetOtpText() {
    _fieldOne.clear();
    _fieldTwo.clear();
    _fieldThree.clear();
    _fieldFour.clear();
    _fieldFive.clear();
    _fieldSix.clear();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    final responsiveHelper = ResponsiveHelper(context: context);

    return BlocConsumer<VerifyPhoneCubit, VerifyPhoneState>(
        listener: (context, state) {
      if (state is SuccessState) {
        context.goNamed(AppRoutes.main);
      } else if (state is ErrorState) {
        resetOtpText();
        GlobalFunctions.showSnackBar(context,
            AppLocalizations.of(context).common_errors_somethingWentWrong,
            color: Colors.red[800], type: "error");
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
                    const SizedBox(height: 30),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpInput(_fieldOne, true, _otpExpired), // auto focus
                        OtpInput(_fieldTwo, false, _otpExpired),
                        OtpInput(_fieldThree, false, _otpExpired),
                        OtpInput(_fieldFour, false, _otpExpired),
                        OtpInput(_fieldFive, false, _otpExpired),
                        OtpInput(_fieldSix, false, _otpExpired),
                      ],
                    ),
                    SizedBox(height: responsiveHelper.defaultGap),
                    BasicTimerWidget(
                        timerTime: 2000,
                        handleOtpExpired: () {
                          setState(() {
                            _otpExpired = true;
                          });
                        }),

                    const SizedBox(
                      height: 30,
                    ),

                    RichText(
                        text: TextSpan(
                            style: const TextStyle(height: 1.3),
                            children: [
                          TextSpan(
                            text: appLocalizations
                                .profile_otpVerification_text_verificationCodeNotReceived,
                            style: textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: "Resend OTP",
                            style: textTheme.bodyMedium!.toLinkStyle(context),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.read<VerifyPhoneCubit>().getSendOtp();
                              },
                          ),
                        ])),

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
                            text: appLocalizations.auth_forgot_link_backToLogin,
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
