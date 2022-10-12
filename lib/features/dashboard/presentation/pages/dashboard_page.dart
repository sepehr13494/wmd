import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/features/authentication/presentation/widgets/custom_app_bar.dart';

class DashboardPage extends AppStatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return const Scaffold(
      appBar: CustomAuthAppBar(),
      body: WidthLimiterWidget(
        child: Center(
          child: Text('This is a blank Dashboard Page'),
        ),
      ),
    );
  }
}
