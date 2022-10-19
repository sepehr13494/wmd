import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

class LoginPage extends AppStatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final formKey = GlobalKey<FormBuilderState>();
    return BlocProvider(
      create: (context) => sl<LoginSignUpCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: WidthLimiterWidget(
          child: BlocConsumer<LoginSignUpCubit, LoginSignUpState>(
            listener:
                BlocHelper.defaultBlocListener(listener: (context, state) {
              if (state is SuccessState) {
                context.goNamed(AppRoutes.dashboard);
              }
            }),
            builder: (context, state) {
              return SingleChildScrollView(
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Text(appLocalizations.auth_login_heading,
                          style: textTheme.headlineSmall),
                      Text(appLocalizations.auth_login_subheading,
                          style: textTheme.bodyMedium),
                      const SizedBox(),
                      AutofillGroup(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextFields.simpleTextField(
                                name: "username",
                                type: TextFieldType.email,
                                hint: appLocalizations.auth_login_input_email_placeholder),
                            const SizedBox(height: 16),
                            PasswordTextField(
                              hint: appLocalizations.auth_login_input_password_placeholder,
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pushNamed(AppRoutes.forgetPassword);
                                },
                                child: Text(
                                  appLocalizations.auth_login_link_forgotPassword,
                                  style: textTheme.bodySmall!
                                      .toLinkStyle(context),
                                )),
                            FormBuilderSwitch(
                                name: "face_id",
                                title: Text(
                                    "Enable sign in with Face ID"),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                contentPadding: EdgeInsets.zero),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginSignUpCubit>().postLogin(
                                  map: formKey.currentState!.instantValue);
                            }
                          },
                          child: Text(appLocalizations.auth_login_button_login)),
                      const SizedBox(),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(height: 1.3),
                              children: [
                                TextSpan(
                                    text:
                                    "${appLocalizations.auth_login_text_noAccount} ",
                                    style: textTheme.bodyMedium),
                                TextSpan(
                                  text: appLocalizations.auth_login_link_signup,
                                  style:
                                  textTheme.bodyMedium!.toLinkStyle(context),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.goNamed(AppRoutes.register);
                                    },
                                ),
                              ]))
                    ]
                        .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: e))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
