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
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';

import '../../../../core/util/app_stateless_widget.dart';

class LoginPage extends AppStatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final formKey = GlobalKey<FormBuilderState>();
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(),
        body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: BlocHelper.defaultBlocListener(listener: (context, state) {
            if (state is SuccessState) {
              //TODO: Navigate to dashboard
              GlobalFunctions.showSnackBar(
                context,
                state.appSuccess.message,
                color: Colors.green,
              );
            }
          }),
          builder: (context, state) {
            return LayoutBuilder(builder: (context, snap) {
              return SingleChildScrollView(
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Text(appLocalizations.login_welcome,
                          style: textTheme.headlineSmall),
                      Text(appLocalizations.login_securely_msg,
                          style: textTheme.bodyMedium),
                      const SizedBox(),
                      AutofillGroup(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextFields.simpleTextField(
                                name: "email", hint: appLocalizations.email_placeholder),
                            const SizedBox(height: 16),
                            const PasswordTextField(),
                            TextButton(onPressed: (){}, child: Text(appLocalizations.login_forget_password,style: textTheme.bodySmall!.toLinkStyle(context),)),
                            FormBuilderSwitch(name: "face_id", title: Text(appLocalizations.login_enable_face_id),decoration: const InputDecoration(
                                border: InputBorder.none
                            ),contentPadding: EdgeInsets.zero),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthenticationCubit>().postLogin(
                                  map: formKey.currentState!.instantValue);
                            }
                          },
                          child: Text(appLocalizations.login)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/faceid.png",
                                height: 30, width: 30),
                            const SizedBox(width: 12),
                            Text(
                              appLocalizations.login_enable_face_id,
                              style: textTheme.bodyMedium!.toLinkStyle(context),
                            )
                          ],
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(height: 1.3),
                              children: [
                            TextSpan(
                                text:
                                    "${appLocalizations.login_dont_have_account} ",
                                style: textTheme.bodyMedium),
                            TextSpan(
                              text: appLocalizations.signup_button,
                              style: textTheme.bodyMedium!.toLinkStyle(context),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                context.go(AppRoutes.register);
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
            });
          },
        ),
      ),
    );
  }
}
