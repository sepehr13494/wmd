import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/app_form_validators.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/password_validation.dart';
import 'package:wmd/features/profile/profile_reset_password/presentation/manager/profile_reset_password_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class ProfileRestPasswordPage extends StatefulWidget {
  const ProfileRestPasswordPage({Key? key}) : super(key: key);

  @override
  AppState<ProfileRestPasswordPage> createState() =>
      _ProfileRestPasswordPageState();
}

class _ProfileRestPasswordPageState extends AppState<ProfileRestPasswordPage> {
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  final formKey = GlobalKey<FormBuilderState>();

  bool lowercase = false,
      uppercase = false,
      numbers = false,
      special = false,
      length = false;

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

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<ProfileResetPasswordCubit>(),
      child: Scaffold(
        appBar: AddAssetHeader(title: "Change password"),
        body: Builder(builder: (context) {
          return BlocListener<ProfileResetPasswordCubit,
              ProfileResetPasswordState>(
            listener:
                BlocHelper.defaultBlocListener(listener: (context, state) {
              if (state is SuccessState) {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.mail,
                                color: Theme.of(context).primaryColor,
                                size: 30),
                            Text(
                              "Password Changed",
                              style: textTheme.titleLarge,
                            ),
                            Text(
                                "You now need to log out and log in again with the new credentials.",
                                textAlign: TextAlign.center),
                            ElevatedButton(
                                onPressed: () {
                                  sl<LocalStorage>().logout();
                                  context.replaceNamed(AppRoutes.splash);
                                },
                                child: Text("logout"))
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: e,
                                  ))
                              .toList(),
                        ),
                      );
                    });
              }
            }),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EachTextField(
                      title: "Old password",
                      hasInfo: false,
                      child: PasswordTextField(name: "oldPassword",showEye: false),
                    ),
                    EachTextField(
                      title: "New password",
                      hasInfo: false,
                      child: PasswordTextField(
                        passwordKey: passwordFieldKey,
                        onChange: onPasswordChange,
                        name: "newPassword",
                      ),
                    ),
                    if (passwordFieldKey.currentState?.value !=
                        null &&
                        !checkPasswordValidity())
                      PasswordValidation(
                        lowercase: lowercase,
                        uppercase: uppercase,
                        numbers: numbers,
                        special: special,
                        length: length,
                      ),
                    EachTextField(
                      title: "Confirm password",
                      hasInfo: false,
                      child: PasswordTextField(name: "confirmPassword",showEye: false,),
                    ),
                    const SizedBox(),
                    ElevatedButton(
                        onPressed: () {
                          final map = formKey.currentState!.instantValue;
                          if (map["confirmPassword"] == map["newPassword"]) {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<ProfileResetPasswordCubit>()
                                  .reset(map: map);
                            }
                          } else {
                            GlobalFunctions.showSnackBar(
                                context, "Confirm password is wrong",
                                color: AppColors.errorColor);
                          }
                        },
                        child: Text("Reset Password")),
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: e,
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}