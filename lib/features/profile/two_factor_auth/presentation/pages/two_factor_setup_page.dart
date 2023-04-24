import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/disable_two_factor_bottom_sheet.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/otp_phone_verify_code_widget.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/otp_phone_verify_widget.dart';
import 'package:wmd/features/settings/data/models/put_settings_params.dart';
import 'package:wmd/global_functions.dart';

class TwoFactorSetupPage extends StatefulWidget {
  const TwoFactorSetupPage({Key? key}) : super(key: key);

  @override
  AppState<TwoFactorSetupPage> createState() => _TwoFactorSetupPageState();
}

class _TwoFactorSetupPageState extends AppState<TwoFactorSetupPage> {
  bool twoFactorEnabled = false;
  // bool emailTwoFactorEnabled = false;
  // bool textTwoFactorEnabled = false;
  String? current2FA = '';

  bool showPhoneVerify = false;
  String verifyPhoneNumber = "";

  final formKeySettings = GlobalKey<FormBuilderState>();
  final formKey = GlobalKey<FormBuilderState>();
  bool enableSubmitButton = false;
  String selectedCountryCode = "BH";

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    print(finalValid);
    Map<String, dynamic> instantValue = formKey.currentState!.instantValue;
    if (finalValid
        //  && lastValue.toString() != instantValue.toString()
        ) {
      if (!enableSubmitButton) {
        setState(() {
          enableSubmitButton = true;
        });
      }
    } else {
      if (enableSubmitButton) {
        setState(() {
          enableSubmitButton = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<TwoFactorCubit>().getTwoFactor();

    final initStateVals = context.read<TwoFactorCubit>().state;

    if (initStateVals is TwoFactorLoaded) {
      final settingsData = initStateVals.entity;

      setState(() {
        twoFactorEnabled = settingsData.twoFactorEnabled;
      });

      if (settingsData.twoFactorEnabled && !settingsData.smsTwoFactorEnabled) {
        setState(() {
          current2FA = "email";
        });
      } else if (settingsData.twoFactorEnabled &&
          settingsData.smsTwoFactorEnabled) {
        setState(() {
          current2FA = "phone";
        });
      }
    }
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);

    final PersonalInformationState personalState =
        context.watch<PersonalInformationCubit>().state;
    final UserStatusState userStatusState =
        context.watch<UserStatusCubit>().state;

    return BlocConsumer<TwoFactorCubit, TwoFactorState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {
      if (state is TwoFactorLoaded) {
        final settingsData = state.entity;

        setState(() {
          twoFactorEnabled = settingsData.twoFactorEnabled;
        });

        if (settingsData.twoFactorEnabled &&
            !settingsData.smsTwoFactorEnabled) {
          setState(() {
            current2FA = "email";
          });
        } else if (settingsData.twoFactorEnabled &&
            settingsData.smsTwoFactorEnabled) {
          setState(() {
            current2FA = "phone";
          });
        }
      }
      if (state is SuccessState) {
        debugPrint("TwoFactorCubit put scuccess");

        final messageSuccess = state.appSuccess?.message;

        if (messageSuccess == "profile_twoFactorAuthentication_toast_on") {
          if (current2FA == "email") {
            GlobalFunctions.showSnackBar(
                context, appLocalizations.profile_toast_email2FAon,
                type: "success");
          } else {
            GlobalFunctions.showSnackBar(
                context, appLocalizations.profile_toast_sms2FAon,
                type: "success");
          }
        } else {
          GlobalFunctions.showSnackBar(
              context, appLocalizations.profile_toast_2FAoff,
              type: "success");
        }

        context.read<TwoFactorCubit>().getTwoFactor();
      }
    }), builder: (context, state) {
      return BlocConsumer<PersonalInformationCubit, PersonalInformationState>(
          listener: (context, perosnalState) {
        if (perosnalState is PersonalInformationLoaded) {
          var json = perosnalState.getNameEntity.toJson();

          debugPrint("json.toString()");
          debugPrint(json.toString());

          json.removeWhere((key, value) => (value == "" || value == null));
          formKey.currentState!.patchValue(json);
        }
      }, builder: (context, state) {
        return Scaffold(
            appBar: const AddAssetHeader(
              title: "2FA",
              considerFirstTime: false,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: appTheme.outlinedButtonTheme.style!.copyWith(
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 38))),
                    ),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile.adaptive(
                        value: twoFactorEnabled,
                        activeColor: AppColors.primary,
                        onChanged: (val) {
                          debugPrint("form toggle");
                          debugPrint(val.toString());

                          if (val == false) {
                            showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                isScrollControlled: true,
                                context: context,
                                builder: (temp) {
                                  return DisableTwoFactorBottomSheet(
                                    callback: () {
                                      setState(() {
                                        twoFactorEnabled = val;
                                        current2FA = null;
                                      });

                                      context
                                          .read<TwoFactorCubit>()
                                          .setTwoFactor(PutSettingsParams(
                                              isPrivacyMode:
                                                  PrivacyInherited.of(context)
                                                      .isBlurred,
                                              twoFactorEnabled: val,
                                              emailTwoFactorEnabled: val,
                                              smsTwoFactorEnabled: val));
                                    },
                                  );
                                });
                          } else {
                            setState(() {
                              twoFactorEnabled = val;
                              current2FA = "email";
                            });

                            context.read<TwoFactorCubit>().setTwoFactor(
                                PutSettingsParams(
                                    isPrivacyMode:
                                        PrivacyInherited.of(context).isBlurred,
                                    twoFactorEnabled: val,
                                    emailTwoFactorEnabled: val,
                                    smsTwoFactorEnabled: false));
                          }
                        },
                        title: Padding(
                            padding: const EdgeInsets.only(
                                bottom:
                                    16.0), // set your desired top padding value
                            child: Text(
                              appLocalizations.profile_twoFactor_page_title,
                              style: textTheme.headlineSmall,
                            )),
                        subtitle: Text(
                          appLocalizations
                              .profile_twofactorauthentication_options_twoFactor_description,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      FormBuilder(
                          key: formKeySettings,
                          // initialValue: {
                          //   "type": "Virtual Meeting",
                          //   "email": (personalState is PersonalInformationLoaded)
                          //       ? personalState.getNameEntity.email
                          //       : ""
                          // },
                          child: Column(children: [
                            ListTile(
                              title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom:
                                          4.0), // set your desired top padding value
                                  child: RichText(
                                      text: TextSpan(
                                          style: const TextStyle(height: 1.3),
                                          children: [
                                        TextSpan(
                                            text: appLocalizations
                                                .profile_twofactorauthentication_options_emailTwoFactor_title
                                                .split("{{email}}")
                                                .first,
                                            style: textTheme.titleMedium),
                                        TextSpan(
                                            text:
                                                ' ${(personalState is PersonalInformationLoaded) ? personalState.getNameEntity.email : ""}',
                                            style: textTheme.bodyMedium),
                                      ]))),

                              // Wrap(children: [
                              //   Text(
                              //     appLocalizations
                              //         .profile_twofactorauthentication_options_emailTwoFactor_title
                              //         .split("{{email}}")
                              //         .first,
                              //     style: textTheme.titleMedium,
                              //   ),
                              //   PrivacyBlurWidget(
                              //     child: Text(
                              //       ' ${(personalState is PersonalInformationLoaded) ? personalState.getNameEntity.email : ""}',
                              //       style: textTheme.bodyMedium,
                              //     ),
                              //   ),
                              // ])),
                              leading: Radio<String>(
                                value: "email",
                                groupValue: current2FA == 'phone'
                                    ? (userStatusState is UserStatusLoaded &&
                                            userStatusState.userStatus
                                                    .mobileNumberVerified ==
                                                true)
                                        ? current2FA
                                        : 'email'
                                    : current2FA,
                                onChanged: (String? value) {
                                  if (twoFactorEnabled) {
                                    setState(() {
                                      current2FA = value;
                                    });

                                    context.read<TwoFactorCubit>().setTwoFactor(
                                        PutSettingsParams(
                                            isPrivacyMode:
                                                PrivacyInherited.of(context)
                                                    .isBlurred,
                                            twoFactorEnabled: true,
                                            emailTwoFactorEnabled: true,
                                            smsTwoFactorEnabled: false));
                                  }
                                },
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: RichText(
                                    text: TextSpan(
                                        style: const TextStyle(height: 1.3),
                                        children: [
                                      TextSpan(
                                          text: appLocalizations
                                              .profile_twofactorauthentication_options_emailTwoFactor_description,
                                          style: textTheme.bodyMedium),
                                      TextSpan(
                                          text:
                                              ' ${(personalState is PersonalInformationLoaded) ? personalState.getNameEntity.email : ""}',
                                          style: textTheme.bodyMedium),
                                    ]))

                                // Wrap(children: [
                                //   Text(
                                //     appLocalizations
                                //         .profile_twofactorauthentication_options_emailTwoFactor_description,
                                //     style: textTheme.bodyMedium,
                                //   ),
                                //   PrivacyBlurWidget(
                                //     child: Text(
                                //       (personalState is PersonalInformationLoaded)
                                //           ? personalState.getNameEntity.email
                                //           : "",
                                //       style: textTheme.bodyMedium,
                                //     ),
                                //   ),
                                // ]),
                                ),
                            const SizedBox(height: 32),
                            ListTile(
                              title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom:
                                          4.0), // set your desired top padding value
                                  child: Wrap(children: [
                                    Text(
                                      appLocalizations
                                          .profile_twofactorauthentication_options_smsTwoFactor_title
                                          .split("{{phoneNumber}}")
                                          .first,
                                      style: textTheme.titleMedium,
                                    ),
                                    PrivacyBlurWidget(
                                      child: Text(
                                        ' ${(personalState is PersonalInformationLoaded) ? personalState.getNameEntity.phoneNumber?.toFormattedNumber() ?? "" : ""}',
                                        style: textTheme.bodyMedium,
                                      ),
                                    ),
                                  ])),
                              leading: Radio<String>(
                                value: "phone",
                                groupValue:
                                    (userStatusState is UserStatusLoaded &&
                                            userStatusState.userStatus
                                                    .mobileNumberVerified ==
                                                true)
                                        ? current2FA
                                        : "",
                                onChanged: (String? value) {
                                  if (twoFactorEnabled) {
                                    setState(() {
                                      current2FA = value;
                                    });

                                    if ((personalState
                                            is PersonalInformationLoaded) &&
                                        (personalState.getNameEntity.phoneNumber
                                                    ?.number !=
                                                "" &&
                                            personalState.getNameEntity
                                                    .phoneNumber?.number !=
                                                null) &&
                                        (userStatusState is UserStatusLoaded &&
                                            userStatusState.userStatus
                                                    .mobileNumberVerified ==
                                                true)) {
                                      context
                                          .read<TwoFactorCubit>()
                                          .setTwoFactor(PutSettingsParams(
                                              isPrivacyMode:
                                                  PrivacyInherited.of(context)
                                                      .isBlurred,
                                              twoFactorEnabled: true,
                                              emailTwoFactorEnabled: false,
                                              smsTwoFactorEnabled: true));
                                    }
                                  }
                                },
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  appLocalizations
                                      .profile_twofactorauthentication_options_smsTwoFactor_description,
                                  style: textTheme.bodyMedium,
                                )),
                            const SizedBox(height: 16),
                          ])),
                      if ((current2FA == 'phone') && verifyPhoneNumber == "")
                        OtpPhoneVerifyWidget(
                            onCancel: () {
                              setState(() {
                                current2FA = "email";
                              });
                            },
                            onSuccess: () {
                              setState(() {
                                verifyPhoneNumber = (personalState
                                        is PersonalInformationLoaded)
                                    ? personalState.getNameEntity.phoneNumber!
                                        .toNumber()
                                    : "";
                              });
                            },
                            formMap:
                                (personalState is PersonalInformationLoaded)
                                    ? personalState.getNameEntity.toJson()
                                    : {}),
                      if ((current2FA == 'phone') && verifyPhoneNumber != "")
                        OtpPhoneVerifyCodeWidget(
                            onSuccess: () {
                              context.read<TwoFactorCubit>().setTwoFactor(
                                  PutSettingsParams(
                                      isPrivacyMode:
                                          PrivacyInherited.of(context)
                                              .isBlurred,
                                      emailTwoFactorEnabled: false,
                                      twoFactorEnabled: true,
                                      smsTwoFactorEnabled: true));
                              Navigator.of(context).pop();
                            },
                            onCancel: () {
                              setState(() {
                                verifyPhoneNumber = "";
                                current2FA = "email";
                              });
                            },
                            phone: verifyPhoneNumber)
                    ]
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: e,
                            ))
                        .toList(),
                  )),
            ));
      });
    });
  }
}
