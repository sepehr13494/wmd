import 'package:flutter/material.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends AppStatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return Scaffold(
       appBar: AppBar(title: Text(appLocalizations.welcome_header)),
       body: Container(),
    );
  }
}
