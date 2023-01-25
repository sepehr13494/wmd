import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/profile/verify_phone/presentation/manager/verify_phone_cubit.dart';
import 'package:wmd/features/profile/verify_phone/presentation/widgets/otp_feild_widget.dart';
import 'package:wmd/injection_container.dart';
import 'package:go_router/go_router.dart';

class VerifyPhoneNumberPage extends StatefulWidget {
  const VerifyPhoneNumberPage({Key? key}) : super(key: key);

  @override
  AppState<VerifyPhoneNumberPage> createState() =>
      _VerifyPhoneNumberPageState();
}

class _VerifyPhoneNumberPageState extends AppState<VerifyPhoneNumberPage> {
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

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);
    final responsiveHelper = ResponsiveHelper(context: context);

    return BlocProvider(
        create: (context) => sl<VerifyPhoneCubit>(),
        child: Scaffold(
          appBar: const AddAssetHeader(
            title: "Phone number Verification",
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
                                "Phone number verification",
                                style: textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Please enter the code you just received on your phone number ending with 4389.",
                                style: textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),

                      SizedBox(height: responsiveHelper.bigger24Gap),

                      Text(
                        "Verification code",
                        style: textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: responsiveHelper.defaultGap),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Didn't get the verification code?",
                        style: textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(height: 1.3),
                              children: [
                            TextSpan(
                              text: "Resend code",
                              style: textTheme.bodyMedium!.toLinkStyle(context),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // context.goNamed(AppRoutes.register);
                                },
                            ),
                          ])),

                      SizedBox(height: responsiveHelper.bigger24Gap),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _otp = _fieldOne.text +
                                      _fieldTwo.text +
                                      _fieldThree.text +
                                      _fieldFour.text;
                                });
                              },
                              child: const Text('Verify')),
                          const SizedBox(
                            height: 18,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Back')),
                        ]),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      // Display the entered OTP code
                    ],
                  )))),
        ));
  }
}

// Create an input widget that takes only one digit
