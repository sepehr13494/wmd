import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/post_resend_verify_phone_usecase.dart';
import 'package:wmd/features/profile/verify_phone/presentation/manager/verify_phone_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class OtpPhoneVerifyCodeWidget extends StatefulWidget {
  final Function onCancel;
  final Function onSuccess;
  final String phone;
  const OtpPhoneVerifyCodeWidget(
      {Key? key,
      required this.onCancel,
      required this.onSuccess,
      required this.phone})
      : super(key: key);

  @override
  AppState<OtpPhoneVerifyCodeWidget> createState() =>
      _OtpPhoneVerifyWidgetState();
}

class _OtpPhoneVerifyWidgetState extends AppState<OtpPhoneVerifyCodeWidget> {
  final formKey = GlobalKey<FormBuilderState>();

  bool enableSubmitButton = false;
  String selectedCode = "";

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

    return BlocProvider(
        create: (context) => sl<VerifyPhoneCubit>()
          ..postResendVerifyPhone(map: {"phoneNumber": widget.phone}),
        child: BlocConsumer<VerifyPhoneCubit, VerifyPhoneState>(
            listener: (context, state) {
          if (state is SuccessState) {
            context.read<UserStatusCubit>().getUserStatus();
            widget.onSuccess();
            // context.goNamed(AppRoutes.settings);
          } else if (state is ErrorState) {
            formKey.currentState?.reset();
            GlobalFunctions.showSnackBar(
                context,
                AppLocalizations.of(context)
                    .profile_otpVerification_error_invalidOTP,
                color: Colors.red[800],
                type: "error");
          }
        }, builder: (context, state) {
          return BlocConsumer<UserStatusCubit, UserStatusState>(
              listener: BlocHelper.defaultBlocListener(
                listener: (context, state) {},
              ),
              builder: (context, state) {
                if (state is UserStatusLoaded &&
                    state.userStatus.mobileNumberVerified != true) {
                  return FormBuilder(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EachTextField(
                              hasInfo: false,
                              title: "Confirm phone number",
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppTextFields.simpleTextField(
                                        name: "code",
                                        hint: appLocalizations
                                            .profile_twofactorauthentication_otp_field_placeholder,
                                        type: TextFieldType.number,
                                        keyboardType: TextInputType.number,
                                        extraValidators: [
                                          (val) {
                                            return (val != null &&
                                                    (val.length > 6 ||
                                                        val.length < 6))
                                                ? "Enter 6 digit valid OTP."
                                                : null;
                                          },
                                        ],
                                        onChanged: (val) {
                                          checkFinalValid(val);
                                          setState(() {
                                            selectedCode = val ?? "";
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                                appLocalizations
                                    .profile_twofactorauthentication_input_description,
                                style: textTheme.bodySmall),
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
                                  child: Text(
                                      appLocalizations.common_button_cancel),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    formKey.currentState?.validate();

                                    if (formKey.currentState!.isValid) {
                                      final otpTemp = formKey.currentState
                                              ?.initialValue["code"] ??
                                          selectedCode;

                                      debugPrint('otpTemp');
                                      debugPrint(otpTemp);
                                      debugPrint(selectedCode);
                                      debugPrint(formKey
                                          .currentState?.initialValue
                                          .toString());
                                      debugPrint(
                                          sl<PostResendVerifyPhoneUseCase>()
                                              .identifier);

                                      context
                                          .read<VerifyPhoneCubit>()
                                          .postVerifyPhone(map: {
                                        // "identifier": state is VerifyOtpLoaded
                                        //     ? state.entity.identifier
                                        //     : "",
                                        "identifier":
                                            sl<PostResendVerifyPhoneUseCase>()
                                                .identifier,
                                        "code": otpTemp
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 50)),
                                  child: Text(appLocalizations
                                      .profile_otpVerification_button_verify),
                                )
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
        }));
  }
}
