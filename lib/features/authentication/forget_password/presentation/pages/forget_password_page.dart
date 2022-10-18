import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/injection_container.dart';

class ForgetPasswordPage extends AppStatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final formKey = GlobalKey<FormBuilderState>();
    return BlocProvider(
      create: (context) => sl<ForgetPasswordCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: BlocListener<ForgetPasswordCubit, BaseState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
            if(state is SuccessState){
              context.goNamed(AppRoutes.verifyEmail,queryParams: {
                "email":formKey.currentState!.instantValue["emailOrUserName"]
              });
            }
          }),
          child: Builder(
            builder: (context) {
              return WidthLimiterWidget(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Text(appLocalizations.auth_forgot_heading,
                          style: textTheme.titleLarge),
                      WidthLimiterWidget(
                        width: 300,
                        child: Text(appLocalizations.auth_forgot_subheading,
                            textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 12),
                      FormBuilder(
                        key: formKey,
                        child: AppTextFields.simpleTextField(
                            type: TextFieldType.email,
                            name: "emailOrUserName",
                            hint: appLocalizations
                                .auth_forgot_input_email_placeholder),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<ForgetPasswordCubit>().forgetPassword(map: formKey.currentState!.instantValue);
                            }
                          },
                          child: Text(appLocalizations.auth_forgot_button_send)),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: WidthLimiterWidget(
                          width: 300,
                          child: Text(
                            '''You have reached the maximum 3 failed attempts, our support team will contact you for help.''',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            context.goNamed(AppRoutes.login);
                          },
                          child: Text(
                            appLocalizations.auth_forgot_link_backToLogin,
                            style: textTheme.bodyMedium!.toLinkStyle(context),
                          ))
                    ]
                        .map((e) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: e,
                        ))
                        .toList(),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
