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
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/loading/loading_screen.dart';
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
          listener: (context, state) {
            if (state is SuccessState) {
              LoadingOverlay().hide();
              context.goNamed(AppRoutes.verifyEmail, queryParams: {
                "email": formKey.currentState!.instantValue["emailOrUserName"],
                "forgotPassword": "true"
              });
            } else if (state is ErrorState) {
              LoadingOverlay().hide();
              context.goNamed(AppRoutes.verifyEmail, queryParams: {
                "email": formKey.currentState!.instantValue["emailOrUserName"],
                "forgotPassword": "true"
              });
            } else if (state is ForgetPasswordLoading) {
              LoadingOverlay().show(context: context, text: "");
            }
          },
          child: Builder(builder: (context) {
            return WidthLimiterWidget(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(appLocalizations.auth_forgot_heading,
                        style: textTheme.titleLarge),
                    WidthLimiterWidget(
                      width: 300,
                      child: Text(appLocalizations.auth_forgot_subheading,
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 20),
                    FormBuilder(
                      key: formKey,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: AppTextFields.simpleTextField(
                          type: TextFieldType.email,
                          name: "emailOrUserName",
                          hint: appLocalizations
                              .auth_forgot_input_email_placeholder),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<ForgetPasswordCubit>().forgetPassword(
                                map: formKey.currentState!.instantValue);
                          }
                        },
                        child: Text(appLocalizations.auth_forgot_button_send)),
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
          }),
        ),
      ),
    );
  }
}
