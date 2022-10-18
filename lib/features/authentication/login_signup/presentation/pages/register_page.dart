import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/terms_widget.dart';
import 'package:wmd/injection_container.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  AppState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends AppState<RegisterPage> {
  bool termsChecked = false;
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<LoginSignUpCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: WidthLimiterWidget(
          child: BlocConsumer<LoginSignUpCubit, LoginSignUpState>(
            listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {
                if (state is SuccessState) {
                  context.goNamed(AppRoutes.verifyEmail,queryParams: {"email":formKey.currentState!.instantValue["email"]});
                }
              },
            ),
            builder: (context, state) {
              return LayoutBuilder(builder: (context, snap) {
                return Stack(
                  children: [
                    const LeafBackground(),
                    SingleChildScrollView(
                      child: FormBuilder(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            Text(appLocalizations.auth_signup_button_createAccount,
                                style: textTheme.headlineSmall),
                            Text(appLocalizations.auth_signup_subHeading,
                                style: textTheme.bodyMedium),
                            const SizedBox(),
                            AutofillGroup(
                              child: Column(
                                children: [
                                  AppTextFields.simpleTextField(
                                    name: "email",
                                    hint: appLocalizations.auth_signup_input_email_placeholder,
                                    type: TextFieldType.email,
                                  ),
                                  const SizedBox(height: 16),
                                  const PasswordTextField()
                                ],
                              ),
                            ),
                            FormBuilderCheckbox(
                              name: "terms",
                              onChanged: (val) {
                                setState(() {
                                  if (val != null) {
                                    termsChecked = val;
                                  }
                                });
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(height: 1.3),
                                      children: [
                                        TextSpan(
                                            text:
                                                "${appLocalizations.auth_signup_checkbox_label} ",
                                            style: textTheme.bodySmall),
                                        TextSpan(
                                          text: appLocalizations.auth_signup_checkbox_termsService,
                                          style: textTheme.bodySmall!
                                              .toLinkStyle(context),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsWidget(),)).then((value) {
                                                if (value ?? false) {
                                                  formKey.currentState!
                                                      .patchValue(
                                                          {"terms": true});
                                                }
                                              });
                                            },
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: termsChecked
                                    ? () {
                                        if (formKey.currentState!.validate()) {
                                          Map<String, dynamic> map = formKey
                                              .currentState!.instantValue;
                                          context
                                              .read<LoginSignUpCubit>()
                                              .postRegister(
                                                  map: formKey.currentState!
                                                      .instantValue);

                                          // context.goNamed(AppRoutes.verifyEmail,
                                          //     extra: map["email"]);
                                          //TextInput.finishAutofillContext();
                                        }
                                      }
                                    : null,
                                child: Text(appLocalizations.auth_signup_button_submit)),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/lock.svg",
                                    height: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      appLocalizations.auth_signup_safeandsecure_title,
                                      style: textTheme.titleMedium!
                                          .copyWith(height: 1.3),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(appLocalizations.auth_verify_text_alreadyVerified),
                                TextButton(
                                    onPressed: () {
                                      context.goNamed(AppRoutes.login);
                                    },
                                    child: Text(
                                      appLocalizations.auth_signup_link_login,
                                      style: textTheme.bodyText1!
                                          .toLinkStyle(context),
                                    ))
                              ],
                            ),
                          ]
                              .map((e) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal:
                                          e is FormBuilderCheckbox ? 4 : 24),
                                  child: e))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
