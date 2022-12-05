import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/features/profile/presentation/widgets/contact_information_widget.dart';
import 'package:wmd/injection_container.dart';

class ProfilePage extends AppStatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return Scaffold(
       appBar: BaseAppBar(title: "Settings"),
       body: SingleChildScrollView(
         child: Column(
           children: [
             ContactInformationWidget()
           ],
         ),
       )
    );
  }
}
