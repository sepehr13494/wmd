import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_blur_warning.dart';
import 'package:wmd/features/profile/core/presentation/pages/profile_page.dart';
import 'package:wmd/features/settings/presentation/page/preferences_page.dart';

class SettingsPage extends AppStatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    const double padding = 16;
    final appTheme = Theme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: appTheme.outlinedButtonTheme.style!.copyWith(
              minimumSize: MaterialStateProperty.all(const Size(0, 38))),
        ),
      ),
      child: Scaffold(
        appBar: const BaseAppBar(),
        // appBar: AddAssetHeader(
        //   title: appLocalizations.profile_tabs_heading,
        //   considerFirstTime: false,
        // ),
        body: Stack(
          children: [
            const LeafBackground(),
            DefaultTabController(
              length: 3,
              child: Padding(
                padding: const EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrivacyBlurWarning(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        appLocalizations.profile_tabs_heading,
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width - padding * 2,
                          child: TabBar(
                            tabs: [
                              Tab(
                                  text: appLocalizations
                                      .profile_tabs_personal_name),
                              Tab(
                                  text: appLocalizations
                                      .profile_tabs_preferences_name),
                              Tab(
                                  text: appLocalizations
                                      .profile_tabs_linkedAccounts_name),
                            ],
                            isScrollable: true,
                          ),
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
          ],
        ),
      ),
    );
  }
}
