import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/line_chart.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/random_map.dart';

class DashboardMainPage extends AppStatelessWidget {
  const DashboardMainPage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: CustomAuthAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RandomWorldMapGenrator(),
            LineChartSample2(),
          ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),child: e)).toList(),
        ),
      ),
    );
  }
}
