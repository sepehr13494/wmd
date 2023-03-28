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
  String phoneNumberValue = "";

  @override
  void initState() {
    super.initState();
    _fieldSix.addListener(() => _onTextChanged(context));
  }

  @override
  void dispose() {
    _fieldSix.dispose();
    super.dispose();
  }

  void _onTextChanged(BuildContext context) {
    debugPrint("working _fieldSix.text----");
    debugPrint(_fieldSix.text);
    debugPrint(_fieldSix.value.toString());

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

      debugPrint(sl<PostResendVerifyPhoneUseCase>().identifier);

      context.read<VerifyPhoneCubit>().postVerifyPhone(map: {
        "identifier": sl<PostResendVerifyPhoneUseCase>().identifier,
        "code": otpTemp
      });
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    final responsiveHelper = ResponsiveHelper(context: context);

    return BlocConsumer<VerifyPhoneCubit, VerifyPhoneState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {
      if (state is SuccessState) {
        context.goNamed(AppRoutes.main);
      }
    }), builder: (context, state) {
      return BlocListener<PersonalInformationCubit, PersonalInformationState>(
          listener: (context, state) {
            if (state is PersonalInformationLoaded) {
              final phone = state.getNameEntity.phoneNumber;

              context.read<VerifyPhoneCubit>().postResendVerifyPhone(
                  map: {"phoneNumber": phone?.toNumber()});

              setState(() {
                phoneNumberValue = phone?.toNumber() ?? "";
              });
            }
          },
          child: Scaffold(
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
                                  "Two-factor authentication",
                                  style: textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Please enter the one time password to verify your account. A code has been sent to the email address we have registered.",
                                  style: textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),

                        SizedBox(height: responsiveHelper.bigger24Gap),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OtpInput(_fieldOne, true), // auto focus
                            OtpInput(_fieldTwo, false),
                            OtpInput(_fieldThree, false),
                            OtpInput(_fieldFour, false),
                            OtpInput(_fieldFive, false),
                            OtpInput(_fieldSix, false),
                          ],
                        ),
                        SizedBox(height: responsiveHelper.defaultGap),
                        const BasicTimerWidget(timerTime: 2000),

                        // Text(
                        //   "Verification code",
                        //   style: textTheme.bodySmall,
                        //   textAlign: TextAlign.center,
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        // Text(
                        //   "Didn't get the verification code?",
                        //   style: textTheme.bodySmall,
                        //   textAlign: TextAlign.center,
                        // ),
                        BlocConsumer<PersonalInformationCubit,
                                PersonalInformationState>(
                            listener: BlocHelper.defaultBlocListener(
                                listener: (context, state) {}),
                            builder: (context, perosnalState) {
                              return RichText(
                                  text: TextSpan(
                                      style: const TextStyle(height: 1.3),
                                      children: [
                                    TextSpan(
                                      text: "Haven’t received the code? ",
                                      style: textTheme.bodyMedium,
                                    ),
                                    TextSpan(
                                      text: "Resend OTP",
                                      style: textTheme.bodyMedium!
                                          .toLinkStyle(context),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context
                                              .read<VerifyPhoneCubit>()
                                              .postResendVerifyPhone(map: {
                                            "phoneNumber": phoneNumberValue
                                          });
                                        },
                                    ),
                                  ]));
                            }),

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
                                    .auth_forgot_link_backToLogin,
                                style:
                                    textTheme.bodyLarge!.toLinkStyle(context),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed(AppRoutes.login);
                                  },
                              )
                            ])),
                        // Display the entered OTP code
                      ],
                    )))),
          ));
    });
  }
}

// Create an input widget that takes only one digit
