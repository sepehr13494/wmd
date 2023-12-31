import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/text_with_info.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_wrapper.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/profile/personal_information/presentation/widgets/country_code_picker.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';
import 'package:wmd/global_functions.dart';
import 'package:country_picker/country_picker.dart';

import '../manager/personal_information_cubit.dart';

class ContactInformationWidget extends StatefulWidget {
  const ContactInformationWidget({Key? key}) : super(key: key);

  @override
  AppState<ContactInformationWidget> createState() =>
      _ContactInformationWidgetState();
}

class _ContactInformationWidgetState
    extends AppState<ContactInformationWidget> {
  TextEditingController emailController = TextEditingController();
  bool enableSubmitButton = false;
  String selectedCountryCode = "BH";
  bool havePhoneNumber = false;
  bool isPhoneEditable = false;
  final formKey = GlobalKey<FormBuilderState>();
  late Map<String, dynamic> lastValue;

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = formKey.currentState!.isValid;
    Map<String, dynamic> instantValue = formKey.currentState!.instantValue;
    if (finalValid && lastValue.toString() != instantValue.toString()) {
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
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    final isTablet = !responsiveHelper.isMobile;

    return BlocListener<PersonalInformationCubit, PersonalInformationState>(
      listener: (context, state) {
        if (state is PersonalInformationLoaded) {
          var json = state.getNameEntity.toJson();
          json.removeWhere((key, value) => (value == "" || value == null));
          formKey.currentState!.patchValue(json);
          emailController.text = state.getNameEntity.email;
          havePhoneNumber = (state.getNameEntity.phoneNumber?.number != "" &&
              state.getNameEntity.phoneNumber?.number != null);
          lastValue = formKey.currentState!.instantValue;
        }
        if (state is SuccessStatePhone) {
          setState(() {
            lastValue = formKey.currentState!.instantValue;
            checkFinalValid("");
          });
          context.read<UserStatusCubit>().getUserStatus();
          context.read<TwoFactorCubit>().getTwoFactor();

          // GlobalFunctions.showSnackBar(
          //     context,
          //     appLocalizations
          //         .profile_tabs_preferences_toast_changePasswordDescription,
          //     type: "success");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Builder(builder: (context) {
          return FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.profile_tabs_personal_headings_contactInfo,
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                RowOrColumn(
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    showRow: isTablet,
                    children: [
                      ExpandedIf(
                        expanded: isTablet,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: EachTextField(
                              hasInfo: false,
                              title: appLocalizations
                                  .profile_tabs_personal_fields_label_email,
                              child: Builder(builder: (context) {
                                return PrivacyBlurWidgetClickable(
                                  child: TextField(
                                    enabled: false,
                                    style: TextStyle(color: Colors.grey[500]),
                                    controller: emailController,
                                  ),
                                );
                              })),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ExpandedIf(
                        expanded: isTablet,
                        child: Column(
                          children: [
                            if (AppConstants.publicMvp2Items)
                              BlocConsumer<UserStatusCubit, UserStatusState>(
                                  listener: BlocHelper.defaultBlocListener(
                                    listener: (context, state) {},
                                  ),
                                  builder: (context, userState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            TextWithInfo(
                                                title: appLocalizations
                                                    .profile_tabs_personal_fields_label_primaryPhoneNumber,
                                                hasInfo: false,
                                                showRequired: false,
                                                tooltipText: ""),
                                            if (havePhoneNumber)
                                              (userState is UserStatusLoaded &&
                                                      userState.userStatus
                                                              .mobileNumberVerified ==
                                                          true)
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            179, 67, 160, 72),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 1),
                                                      child: Text(
                                                        appLocalizations
                                                            .profile_tabs_personal_fields_label_verified,
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            20, 199, 61, 61),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 1),
                                                      child: Text(
                                                        appLocalizations
                                                            .profile_tabs_personal_fields_label_notVerified,
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              100,
                                                              218,
                                                              129,
                                                              129),
                                                        ),
                                                      ),
                                                    )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PrivacyBlurWidgetClickable(
                                                child: CountryCodePicker(
                                                    enabled: isPhoneEditable,
                                                    onChange: (val) {
                                                      setState(() {
                                                        selectedCountryCode =
                                                            val?.countryCode ??
                                                                "";
                                                      });

                                                      checkFinalValid(val);
                                                    }),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child:
                                                    PrivacyBlurWidgetClickable(
                                                  child: Stack(
                                                    alignment: context
                                                                .read<
                                                                    LocalizationManager>()
                                                                .state
                                                                .languageCode ==
                                                            'en'
                                                        ? Alignment.topRight
                                                        : Alignment.topLeft,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        // height: 80,
                                                        child: AppTextFields
                                                            .simpleTextField(
                                                                name:
                                                                    "phoneNumber",
                                                                hint: appLocalizations
                                                                    .profile_tabs_personal_placeholders_enterPhone,
                                                                type:
                                                                    TextFieldType
                                                                        .number,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                minLines: 1,
                                                                enabled:
                                                                    isPhoneEditable,
                                                                extraValidators: [
                                                                  (val) {
                                                                    return (!val!.contains(RegExp(
                                                                            r'^[0-9]*$')))
                                                                        ? appLocalizations
                                                                            .scheduleMeeting_phoneNumber_errors_inValid
                                                                        : null;
                                                                  },
                                                                  (val) {
                                                                    return (val != null &&
                                                                            val !=
                                                                                "" &&
                                                                            selectedCountryCode ==
                                                                                "BH" &&
                                                                            (val.length > 8 ||
                                                                                val.length <
                                                                                    8))
                                                                        ? appLocalizations.common_errors_phoneNumberLength.replaceAll(
                                                                            "{{digit}}",
                                                                            8.toString())
                                                                        : null;
                                                                  },
                                                                ],
                                                                onChanged:
                                                                    checkFinalValid),
                                                      ),
                                                      if (!isPhoneEditable)
                                                        IconButton(
                                                          icon: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0, 0, 0, 0),
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/edit_square.svg",
                                                              height: 30,
                                                              color: AppColors
                                                                  .primary,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              isPhoneEditable =
                                                                  true;
                                                            });
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        if ((userState is UserStatusLoaded &&
                                                userState.userStatus
                                                        .mobileNumberVerified !=
                                                    true) &&
                                            !isPhoneEditable)
                                          havePhoneNumber
                                              ? RichText(
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                          height: 1.3),
                                                      children: [
                                                      TextSpan(
                                                          text: appLocalizations
                                                              .profile_tabs_personal_label_verifyNumber,
                                                          style: textTheme
                                                              .bodyMedium),
                                                      TextSpan(
                                                        text: appLocalizations
                                                            .profile_tabs_personal_label_sendCode,
                                                        style: textTheme
                                                            .bodyMedium!
                                                            .toLinkStyle(
                                                                context),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                context.pushNamed(
                                                                    AppRoutes
                                                                        .verifyPhone,
                                                                    queryParams: {
                                                                      "phoneNumber":
                                                                          "+${(formKey.currentState!.instantValue["country"] as Country).phoneCode} ${formKey.currentState!.instantValue["phoneNumber"]}"
                                                                    });
                                                              },
                                                      ),
                                                      TextSpan(
                                                          text:
                                                              ' ${appLocalizations.profile_tabs_personal_label_toEnable2FA}',
                                                          style: textTheme
                                                              .bodyMedium),
                                                    ]))
                                              : Text(
                                                  appLocalizations
                                                      .profile_tabs_personal_label_verifyNumber,
                                                  style: textTheme.bodyMedium),
                                        if (isPhoneEditable)
                                          BlocConsumer<TwoFactorCubit,
                                                  TwoFactorState>(
                                              listener: BlocHelper
                                                  .defaultBlocListener(
                                                      listener:
                                                          (context, state) {}),
                                              builder: (context, state) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            isPhoneEditable =
                                                                false;
                                                          });
                                                        },
                                                        child: Text(
                                                          appLocalizations
                                                              .common_button_cancel,
                                                          style: textTheme
                                                              .bodySmall!
                                                              .toLinkStyle(
                                                                  context),
                                                        )),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    if (state
                                                        is TwoFactorLoaded)
                                                      ElevatedButton(
                                                        onPressed:
                                                            !enableSubmitButton
                                                                ? null
                                                                : () {
                                                                    if (formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      debugPrint(formKey
                                                                          .currentState!
                                                                          .instantValue
                                                                          .toString());

                                                                      context
                                                                          .read<
                                                                              PersonalInformationCubit>()
                                                                          .setNumber(
                                                                              map: formKey.currentState!.instantValue);

                                                                      if (state
                                                                          .entity
                                                                          .smsTwoFactorEnabled) {
                                                                        context.read<TwoFactorCubit>().setTwoFactor(PutSettingsParams(
                                                                            isPrivacyMode: PrivacyInherited.of(context)
                                                                                .isBlurred,
                                                                            twoFactorEnabled:
                                                                                false,
                                                                            emailTwoFactorEnabled:
                                                                                false,
                                                                            smsTwoFactorEnabled:
                                                                                state.entity.smsTwoFactorEnabled));
                                                                      }

                                                                      context.pushNamed(
                                                                          AppRoutes
                                                                              .verifyPhone,
                                                                          queryParams: {
                                                                            "phoneNumber":
                                                                                "+${(formKey.currentState!.instantValue["country"] as Country).phoneCode} ${formKey.currentState!.instantValue["phoneNumber"]}"
                                                                          });

                                                                      setState(
                                                                          () {
                                                                        isPhoneEditable =
                                                                            false;
                                                                      });

                                                                      AnalyticsUtils.triggerEvent(
                                                                          action: AnalyticsUtils
                                                                              .updateVerifyPhoneAction,
                                                                          params:
                                                                              AnalyticsUtils.updateVerifyPhoneEvent);
                                                                    }
                                                                  },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                minimumSize:
                                                                    const Size(
                                                                        100,
                                                                        50)),
                                                        child: Text(appLocalizations
                                                            .profile_tabs_personal_button_updateAndVerify),
                                                      )
                                                  ],
                                                );
                                              })
                                      ],
                                    );
                                  }),
                          ]
                              .map((e) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: e,
                                  ))
                              .toList(),
                        ),
                      ),
                    ])
              ],
            ),
          );
        }),
      ),
    );
  }
}
