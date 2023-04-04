import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/profile/core/presentation/widgets/language_bottom_sheet.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/features/profile/personal_information/presentation/widgets/country_code_picker.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/disable_two_factor_bottom_sheet.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/otp_phone_verify_code_widget.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/otp_phone_verify_widget.dart';
import 'package:wmd/features/settings/data/models/put_settings_params.dart';
import 'package:wmd/injection_container.dart';

class TwoFactorSetupPage extends StatefulWidget {
  const TwoFactorSetupPage({Key? key}) : super(key: key);

  @override
  AppState<TwoFactorSetupPage> createState() => _TwoFactorSetupPageState();
}

class _TwoFactorSetupPageState extends AppState<TwoFactorSetupPage> {
  bool twoFactorEnabled = false;
  bool emailTwoFactorEnabled = false;
  bool textTwoFactorEnabled = false;
  String verifyPhoneNumber = "";

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
        emailTwoFactorEnabled = settingsData.emailTwoFactorEnabled;
        textTwoFactorEnabled = settingsData.smsTwoFactorEnabled;
      });
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
          emailTwoFactorEnabled = settingsData.emailTwoFactorEnabled;
          textTwoFactorEnabled = settingsData.smsTwoFactorEnabled;
        });
      }
      if (state is SuccessState) {
        debugPrint("TwoFactorCubit put scuccess");

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
            appBar: AddAssetHeader(
              title: appLocalizations.profile_twoFactor_header,
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
                        onChanged: (val) {
                          debugPrint("form toggle");
                          debugPrint(val.toString());

                          if (val == false) {
                            showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return DisableTwoFactorBottomSheet(
                                    callback: (() => setState(() {
                                          twoFactorEnabled = val;
                                          emailTwoFactorEnabled = val;
                                          textTwoFactorEnabled = val;
                                        })),
                                  );
                                });

                            context.read<TwoFactorCubit>().setTwoFactor(
                                PutSettingsParams(
                                    isPrivacyMode:
                                        PrivacyInherited.of(context).isBlurred,
                                    twoFactorEnabled: val,
                                    emailTwoFactorEnabled: val,
                                    smsTwoFactorEnabled: val));
                          } else {
                            setState(() {
                              twoFactorEnabled = val;
                              emailTwoFactorEnabled = val;
                            });

                            context.read<TwoFactorCubit>().setTwoFactor(
                                PutSettingsParams(
                                    isPrivacyMode:
                                        PrivacyInherited.of(context).isBlurred,
                                    emailTwoFactorEnabled: val,
                                    smsTwoFactorEnabled: val));
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
                          appLocalizations.profile_twoFactor_page_subTitle,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      SwitchListTile.adaptive(
                        value: emailTwoFactorEnabled,
                        onChanged: (val) {
                          if (val == false && textTwoFactorEnabled == false) {
                            setState(() {
                              emailTwoFactorEnabled = val;
                              twoFactorEnabled = val;
                            });
                          }

                          setState(() {
                            emailTwoFactorEnabled = val;
                          });

                          context.read<TwoFactorCubit>().setTwoFactor(
                              PutSettingsParams(
                                  isPrivacyMode:
                                      PrivacyInherited.of(context).isBlurred,
                                  emailTwoFactorEnabled: val,
                                  smsTwoFactorEnabled: textTwoFactorEnabled));
                        },
                        title: Padding(
                            padding: const EdgeInsets.only(
                                bottom:
                                    8.0), // set your desired top padding value
                            child: Text(
                              appLocalizations
                                  .profile_twoFactor_page_email_title,
                              style: textTheme.titleMedium,
                            )),
                        subtitle: Text(
                          appLocalizations.profile_twoFactor_page_email_subTitle
                              .replaceFirst(
                                  "email@email.com",
                                  (personalState is PersonalInformationLoaded)
                                      ? personalState.getNameEntity.email
                                      : ""),
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      SwitchListTile.adaptive(
                        value: textTwoFactorEnabled,
                        onChanged: (val) {
                          setState(() {
                            twoFactorEnabled = val ? true : twoFactorEnabled;
                            textTwoFactorEnabled = val;
                          });

                          if ((personalState is PersonalInformationLoaded) &&
                              (personalState
                                          .getNameEntity.phoneNumber?.number !=
                                      "" &&
                                  personalState
                                          .getNameEntity.phoneNumber?.number !=
                                      null) &&
                              (userStatusState is UserStatusLoaded &&
                                  userStatusState
                                          .userStatus.mobileNumberVerified ==
                                      true)) {
                            context.read<TwoFactorCubit>().setTwoFactor(
                                PutSettingsParams(
                                    isPrivacyMode:
                                        PrivacyInherited.of(context).isBlurred,
                                    emailTwoFactorEnabled:
                                        emailTwoFactorEnabled,
                                    smsTwoFactorEnabled: val));
                          }
                        },
                        title: Padding(
                            padding: const EdgeInsets.only(
                                bottom:
                                    8.0), // set your desired top padding value
                            child: Text(
                              '${appLocalizations.profile_twoFactor_page_phone_title}: ${(personalState is PersonalInformationLoaded) ? personalState.getNameEntity.phoneNumber?.toNumber() ?? "" : ""}',
                              style: textTheme.titleMedium,
                            )),
                        subtitle: Text(
                          appLocalizations
                              .profile_twoFactor_page_phone_subTitle,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      if (textTwoFactorEnabled && verifyPhoneNumber == "")
                        OtpPhoneVerifyWidget(
                            onCancel: () {
                              context.read<TwoFactorCubit>().setTwoFactor(
                                  PutSettingsParams(
                                      isPrivacyMode:
                                          PrivacyInherited.of(context)
                                              .isBlurred,
                                      emailTwoFactorEnabled:
                                          emailTwoFactorEnabled,
                                      smsTwoFactorEnabled: false));
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
                      if (textTwoFactorEnabled && verifyPhoneNumber != "")
                        OtpPhoneVerifyCodeWidget(
                            onSuccess: () {
                              context.read<TwoFactorCubit>().setTwoFactor(
                                  PutSettingsParams(
                                      isPrivacyMode:
                                          PrivacyInherited.of(context)
                                              .isBlurred,
                                      emailTwoFactorEnabled: true,
                                      twoFactorEnabled: true,
                                      smsTwoFactorEnabled:
                                          textTwoFactorEnabled));
                              Navigator.of(context).pop();
                            },
                            onCancel: () {
                              context.read<TwoFactorCubit>().setTwoFactor(
                                  PutSettingsParams(
                                      isPrivacyMode:
                                          PrivacyInherited.of(context)
                                              .isBlurred,
                                      emailTwoFactorEnabled:
                                          emailTwoFactorEnabled,
                                      smsTwoFactorEnabled: false));
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
