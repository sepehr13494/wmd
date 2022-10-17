import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/width_limitter.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/injection_container.dart';

class DashboardPage extends AppStatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Scaffold(
      appBar: CustomAuthAppBar(),
      body: WidthLimiterWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(onPressed: (){
              sl<LocalStorage>().logout();
              context.goNamed(AppRoutes.splash);
            },child: Text('This is a blank Dashboard Page')),
          ),
        ),
      ),
    );
  }
}
