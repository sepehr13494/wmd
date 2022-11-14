import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/extentions/app_form_validators.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/authentication/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/password_validation.dart';
import 'package:wmd/injection_container.dart';

class ResetPasswordPage extends StatefulWidget {
  final Map<String, dynamic> verifyMap;

  const ResetPasswordPage({Key? key, required this.verifyMap})
      : super(key: key);

  @override
  AppState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends AppState<ResetPasswordPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  bool lowercase = false,
      uppercase = false,
      numbers = false,
      special = false,
      length = false;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);

    void validatePassword(dynamic value) {
      if (value == null || value == '') {
        setState(() {
          lowercase = false;
          uppercase = false;
          numbers = false;
          special = false;
          length = false;
        });
      }

      setState(() {
        lowercase = AppFormValidators.checkLowerCaseValidation(value);
        uppercase = AppFormValidators.checkUpperCaseValidation(value);
        numbers = AppFormValidators.checkNumberValidation(value);
        special = AppFormValidators.specialCharsValidation(value);
        length = AppFormValidators.lengthValidation(value);
      });
    }

    void onPasswordChange(String? e) {
      validatePassword(passwordFieldKey.currentState?.value);
    }

    bool checkPasswordValidity() {
      return (lowercase && uppercase && special && length);
    }

    return BlocProvider(
      create: (context) => sl<ForgetPasswordCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: BlocConsumer<ForgetPasswordCubit, BaseState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
            if (state is SuccessState) {
              context.goNamed(AppRoutes.verifyEmail, queryParams: {
                "email": formKey.currentState!.instantValue["emailOrUserName"],
                "forgotPassword": "true"
              });
            }
          }),
          builder: (context, state) {
            if (widget.verifyMap["email"] == null ||
                widget.verifyMap["expirydate"] == null ||
                widget.verifyMap["data"] == null) {
              return WidthLimiterWidget(
                  child: SingleChildScrollView(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.cancel_rounded, size: 70),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: responsiveHelper.bigger16Gap,
                          horizontal: 15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              appLocalizations.auth_change_linkExpired_heading,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: responsiveHelper.xxLargeFontSize),
                            ),
                            SizedBox(height: responsiveHelper.biggerGap),
                            Text(
                              appLocalizations
                                  .auth_change_linkExpired_subheading,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.apply(
                                  color: AppColors.dashBoardGreyTextColor),
                            ),
                          ])),
                  SizedBox(height: responsiveHelper.biggerGap),
                  SizedBox(
                      width: 160, // <-- Your width
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppRoutes.login);
                        },
                        child: Text(
                          appLocalizations.auth_change_button_backToLogin,
                        ),
                      ))
                ],
              )));
            }

            if (state is SuccessState) {
              return WidthLimiterWidget(
                  child: SingleChildScrollView(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/success.svg",
                    height: 70,
                  ),
                  // Icon(Icons.check_circle, color: Colors.green[300]),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: responsiveHelper.bigger16Gap,
                          horizontal: 15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              appLocalizations
                                  .auth_change_passwordUpdatedSuccess_heading,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: responsiveHelper.xxLargeFontSize),
                            ),
                            SizedBox(height: responsiveHelper.biggerGap),
                            Text(
                              appLocalizations
                                  .auth_change_passwordUpdatedSuccess_subheading,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.apply(
                                  color: AppColors.dashBoardGreyTextColor),
                            ),
                          ])),
                  SizedBox(height: responsiveHelper.biggerGap),
                  SizedBox(
                      width: 160, // <-- Your width
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppRoutes.login);
                        },
                        child: Text(
                          appLocalizations
                              .auth_change_button_passwordUpdatedGoToLogin,
                        ),
                      ))
                ],
              )));
            }

            return WidthLimiterWidget(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(appLocalizations.auth_change_heading,
                        style: TextStyle(
                            fontSize: responsiveHelper.xxLargeFontSize)),
                    WidthLimiterWidget(
                      width: 300,
                      child: Text(appLocalizations.auth_change_subheading,
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 50),
                    FormBuilder(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          PasswordTextField(
                              passwordKey: passwordFieldKey,
                              onChange: onPasswordChange,
                              hint: appLocalizations
                                  .auth_login_input_password_placeholder),
                          if (passwordFieldKey.currentState?.value != null &&
                              !checkPasswordValidity())
                            PasswordValidation(
                              lowercase: lowercase,
                              uppercase: uppercase,
                              numbers: numbers,
                              special: special,
                              length: length,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          PasswordTextField(
                              hint: appLocalizations
                                  .auth_change_input_confirmPassword_placeholder),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final dataMap =
                                Map.of(formKey.currentState!.instantValue);

                            dataMap.addEntries({
                              "email": widget.verifyMap['email'],
                              "expiryDate": widget.verifyMap['expirydate'],
                              "data": widget.verifyMap['data']
                            }.entries);

                            log("data submit", error: dataMap);

                            context
                                .read<ForgetPasswordCubit>()
                                .resetPassword(map: dataMap);
                          }
                        },
                        child: Text(appLocalizations
                            .auth_change_button_changePassword)),
                    TextButton(
                        onPressed: () {
                          context.goNamed(AppRoutes.login);
                        },
                        child: Text(
                          appLocalizations.auth_forgot_link_backToLogin,
                          style: textTheme.bodyMedium!.toLinkStyle(context),
                        ))
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: e,
                          ))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
