import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';

class RegisterPage extends AppStatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: LayoutBuilder(builder: (context, snap) {
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
                                        .toLinkStyle(context)),
                              ]),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Map<String,dynamic> map = formKey.currentState!.instantValue;
                            context.pushNamed(AppRoutes.verifyEmail,extra: map["email"]);
                            //TextInput.finishAutofillContext();
                          }
                        },
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
                              style:
                                  textTheme.titleMedium!.copyWith(height: 1.3),
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
                              context.go(AppRoutes.login);
                            },
                            child: Text(
                              appLocalizations.login,
                              style: textTheme.bodyText1!.toLinkStyle(context),
                            ))
                      ],
                    ),
                  ]
                      .map((e) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: e is FormBuilderCheckbox ? 4 : 24),
                          child: e))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
