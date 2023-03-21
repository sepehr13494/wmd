import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/pages/two_factor_setup_page.dart';

class TwoFactorSetting extends AppStatelessWidget {
  const TwoFactorSetting({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Two-factor authentication",
            style: textTheme.titleMedium,
          ),
          Text(
            "Two-factor authentication protects your account by adding an extra security step when you sign in.",
            style: textTheme.bodyMedium,
          ),
          Text(
            "Enabled for email address",
            style: textTheme.titleMedium,
          ),
          OutlinedButton(
              onPressed: () {
                context.goNamed(AppRoutes.twoFactorAuth);
              },
              child: Text("Change 2FA"))
        ]
            .map((e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: e,
                ))
            .toList());
  }
}
