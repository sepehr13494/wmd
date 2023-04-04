import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
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
import 'package:wmd/features/settings/data/models/put_settings_params.dart';
import 'package:wmd/injection_container.dart';

class OtpPhoneVerifyWidget extends StatefulWidget {
  final Function onCancel;
  final Function onSuccess;
  final Map<String, dynamic> formMap;
  const OtpPhoneVerifyWidget(
      {Key? key,
      required this.onCancel,
      required this.onSuccess,
      required this.formMap})
      : super(key: key);

  @override
  AppState<OtpPhoneVerifyWidget> createState() => _OtpPhoneVerifyWidgetState();
}

class _OtpPhoneVerifyWidgetState extends AppState<OtpPhoneVerifyWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _inputFormValue = {};
  bool enableSubmitButton = false;
  String selectedCountryCode = "BH";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    debugPrint("widget.formMap");
    debugPrint(widget.formMap.toString());

    final tempMap = widget.formMap;
    tempMap.removeWhere((key, value) => (value == "" || value == null));
    _inputFormValue = tempMap;

    // try {
    //   tempMap.removeWhere((key, value) => (value == "" || value == null));
    //   formKey.currentState?.patchValue(tempMap);
    // } catch (e) {
    //   debugPrint("widget.formMap error");
    //   debugPrint(e.toString());
    // }
  }

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
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final appTheme = Theme.of(context);

    final PersonalInformationState personalState =
        context.watch<PersonalInformationCubit>().state;

    return BlocConsumer<UserStatusCubit, UserStatusState>(
        listener: BlocHelper.defaultBlocListener(
          listener: (context, state) {},
        ),
        builder: (context, state) {
          if (state is UserStatusLoaded &&
              state.userStatus.mobileNumberVerified != true) {
            return FormBuilder(
                initialValue: _inputFormValue,
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EachTextField(
                        hasInfo: false,
                        title: appLocalizations
                            .profile_tabs_personal_fields_label_primaryPhoneNumber,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CountryCodePicker(
                                onChange: (val) {
                                  setState(() {
                                    selectedCountryCode =
                                        val?.countryCode ?? "";
                                  });

                                  checkFinalValid(val);
                                },
                                enabled: widget.formMap["country"] == null),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AppTextFields.simpleTextField(
                                  name: "phoneNumber",
                                  hint:
                                      '${appLocalizations.profile_tabs_personal_fields_label_primaryPhoneNumber.substring(0, 18)}..',
                                  type: TextFieldType.number,
                                  enabled:
                                      widget.formMap["phoneNumber"] == null,
                                  keyboardType: TextInputType.number,
                                  extraValidators: [
                                    (val) {
                                      return (!val!
                                              .contains(RegExp(r'^[0-9]*$')))
                                          ? appLocalizations
                                              .scheduleMeeting_phoneNumber_errors_inValid
                                          : null;
                                    },
                                    (val) {
                                      return (val != null &&
                                              val != "" &&
                                              selectedCountryCode == "BH" &&
                                              (val.length > 8 ||
                                                  val.length < 8))
                                          ? appLocalizations
                                              .common_errors_phoneNumberLength
                                              .replaceAll(
                                                  "{{digit}}", 8.toString())
                                          : null;
                                    },
                                  ],
                                  onChanged: checkFinalValid),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              widget.onCancel();
                              // View Asset detail button
                              // context.goNamed(AppRoutes.addAssetsView);
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(100, 50)),
                            child: Text(appLocalizations.common_button_cancel),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          BlocConsumer<PersonalInformationCubit,
                                  PersonalInformationState>(
                              listener: BlocHelper.defaultBlocListener(
                                  listener: (context, state) {
                            if (state is SuccessStatePhone) {
                              context
                                  .read<PersonalInformationCubit>()
                                  .getName();
                            }
                            if (state is PersonalInformationLoaded) {
                              widget.onSuccess();
                            }
                          }), builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (widget.formMap["phoneNumber"] == null) {
                                  context
                                      .read<PersonalInformationCubit>()
                                      .setNumber(
                                          map: formKey
                                              .currentState!.instantValue);

                                  Timer(const Duration(seconds: 5),
                                      () => widget.onSuccess());
                                } else {
                                  widget.onSuccess();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 50)),
                              child: const Text("Send code"),
                            );
                          })
                        ],
                      )
                    ]
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: e,
                            ))
                        .toList()));
          }

          return const SizedBox();
        });
  }
}
