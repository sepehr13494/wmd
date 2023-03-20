import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/features/add_assets/core/presentation/widgets/add_asset_header.dart';
import 'package:wmd/features/profile/core/presentation/pages/profile_page.dart';
import 'package:wmd/features/settings/presentation/page/preferences_page.dart';

class SettingsPage extends AppStatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final appTheme = Theme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: appTheme.outlinedButtonTheme.style!.copyWith(
              minimumSize: MaterialStateProperty.all(const Size(0, 38))),
        ),
      ),
      child: Scaffold(
        appBar: AddAssetHeader(
          title: appLocalizations.profile_tabs_heading,
          considerFirstTime: false,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Row(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: appLocalizations.profile_tabs_personal_name),
                      Tab(text: appLocalizations.profile_tabs_preferences_name),
                      Tab(
                          text: appLocalizations
                              .profile_tabs_linkedAccounts_name),
                    ],
                    isScrollable: true,
                  ),
                  const Spacer(),
                ],
              ),
              const Divider(
                height: 0.5,
                thickness: 0.5,
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  const ProfilePage(),
                  const PreferencesPage(),
                  Container(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
