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
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/presentation/widgets/terms_widget.dart';
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
      create: (context) => sl<AuthenticationCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: WidthLimiterWidget(
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
            listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {
                if (state is SuccessState) {
                  context.goNamed(AppRoutes.verifyEmail,
                      extra: RegisterParams.fromJson(
                          formKey.currentState!.instantValue));
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
                            Text(appLocalizations.create_account,
                                style: textTheme.headlineSmall),
                            Text(appLocalizations.to_start,
                                style: textTheme.bodyMedium),
                            const SizedBox(),
                            AutofillGroup(
                              child: Column(
                                children: [
                                  AppTextFields.simpleTextField(
                                    name: "email",
                                    hint: appLocalizations.email_placeholder,
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
                                                "${appLocalizations.sign_up_terms_conditions} ",
                                            style: textTheme.bodySmall),
                                        TextSpan(
                                          text: appLocalizations.sign_up_policy,
                                          style: textTheme.bodySmall!
                                              .toLinkStyle(context),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const Dialog(
                                                      child: TermsWidget(),
                                                    );
                                                  }).then((value) {
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
                                              .read<AuthenticationCubit>()
                                              .postRegister(
                                                  map: formKey.currentState!
                                                      .instantValue);

                                          // context.goNamed(AppRoutes.verifyEmail,
                                          //     extra: map["email"]);
                                          //TextInput.finishAutofillContext();
                                        }
                                      }
                                    : null,
                                child: Text(appLocalizations.sign_up_continue)),
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
                                      appLocalizations.safe_secure_disclaimer,
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
                                Text(appLocalizations.already_have_account),
                                TextButton(
                                    onPressed: () {
                                      context.goNamed(AppRoutes.login);
                                    },
                                    child: Text(
                                      appLocalizations.login,
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
