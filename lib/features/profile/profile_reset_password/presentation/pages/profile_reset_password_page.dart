import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/each_form_item.dart';
import 'package:wmd/features/profile/profile_reset_password/presentation/manager/profile_reset_password_cubit.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class ProfileRestPasswordPage extends AppStatelessWidget {
  const ProfileRestPasswordPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final formKey = GlobalKey<FormBuilderState>();
    return BlocProvider(
      create: (context) => sl<ProfileResetPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text("reset password")),
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
                            Text("Password Changed Successfully"),
                          ],
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
                      child: PasswordTextField(name: "oldPassword"),
                    ),
                    EachTextField(
                      title: "New password",
                      hasInfo: false,
                      child: PasswordTextField(name: "newPassword"),
                    ),
                    EachTextField(
                      title: "Confirm password",
                      hasInfo: false,
                      child: PasswordTextField(name: "confirmPassword"),
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
                          } else{
                            GlobalFunctions.showSnackBar(context, "Confirm password is wrong",color: AppColors.errorColor);
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
