import 'package:flutter/material.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';

class VerifySuccessPage extends AppStatelessWidget {
  const VerifySuccessPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: Center(child: Text("success verify page"),),
    );
  }
}
