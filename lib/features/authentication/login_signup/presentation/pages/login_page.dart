import 'dart:io';

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
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/social_auth_bar.dart';
import 'package:wmd/features/splash/presentation/manager/splash_cubit.dart';
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
        appBar: const CustomAuthAppBar(automaticallyImplyLeading: false),
        body: WidthLimiterWidget(
          child: BlocConsumer<LoginSignUpCubit, LoginSignUpState>(
            listener:
                BlocHelper.defaultBlocListener(listener: (context, state) {
              if (state is SuccessState) {
                context.goNamed(AppRoutes.authCheck);
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
                                hint: appLocalizations
                                    .auth_login_input_email_placeholder),
                            const SizedBox(height: 16),
                            PasswordTextField(
                              hint: appLocalizations
                                  .auth_login_input_password_placeholder,
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pushNamed(AppRoutes.forgetPassword);
                                },
                                child: Text(
                                  appLocalizations
                                      .auth_login_link_forgotPassword,
                                  style:
                                      textTheme.bodySmall!.toLinkStyle(context),
                                )),
                            const SizedBox(height: 16),
                            Center(
                              child: BlocProvider(
                                create: (context) =>
                                    sl<SplashCubit>()..initSplash(time: 200),
                                child: BlocBuilder<SplashCubit, SplashState>(
                                  builder: (context, state) {
                                    return state is SplashLoaded
                                        ? (state.isLogin &&
                                                sl<LocalStorage>()
                                                    .getLocalAuth())
                                            ? InkWell(
                                                onTap: () async {
                                                  final didAuth = await context
                                                      .read<LocalAuthManager>()
                                                      .authenticate(context);
                                                  if (didAuth) {
                                                    // ignore: use_build_context_synchronously
                                                    context.goNamed(
                                                        AppRoutes.main);
                                                  } else {
                                                    // ignore: use_build_context_synchronously
                                                    GlobalFunctions.showSnackBar(
                                                        context,
                                                        "please enable biometrics on your device");
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      appLocalizations
                                                          .profile_localAuth_pleaseAuthenticate,
                                                      style: textTheme
                                                          .bodyMedium!
                                                          .toLinkStyle(context),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Icon(
                                                      Icons.fingerprint,
                                                      size: 30,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : const SizedBox()
                                        : const SizedBox();
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
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
                          child:
                              Text(appLocalizations.auth_login_button_login)),
                      const SizedBox(),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     const Divider(),
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(horizontal: 24),
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       child: Text(
                      //         appLocalizations.auth_login_text_social,
                      //         style: textTheme.bodySmall!
                      //             .apply(fontWeightDelta: -2),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SocialAuthBar(),
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
                              style: textTheme.bodyMedium!.toLinkStyle(context),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.goNamed(AppRoutes.register);
                                },
                            ),
                          ])),
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
