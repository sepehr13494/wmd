import 'package:flutter/material.dart';
import '../../../../core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/custom_app_bar.dart';

class WelcomePage extends AppStatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: Container(),
    );
  }
}
