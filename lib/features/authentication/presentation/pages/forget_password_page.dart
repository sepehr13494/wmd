import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/text_style_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_text_fields.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';

class ForgetPasswordPage extends AppStatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text(appLocalizations.login_forget_password,
                style: textTheme.titleLarge),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 350
              ),
              child: Text(appLocalizations.safe_secure_disclaimer),
            ),
            const SizedBox(height: 12),
            FormBuilder(
              key: formKey,
              child: const PasswordTextField(),
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                child: Text(appLocalizations.sign_up_resend)),
            Container(
              constraints: const BoxConstraints(
                  maxWidth: 350
              ),
              child: Text(appLocalizations.safe_secure_disclaimer),
            ),
            TextButton(
                onPressed: () {
                  context.go(AppRoutes.login);
                },
                child: Text(
                  appLocalizations.login,
                  style: textTheme.bodyMedium!.toLinkStyle(context),
                ))
          ]
              .map((e) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
