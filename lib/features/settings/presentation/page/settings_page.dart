import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_blur_warning.dart';
import 'package:wmd/features/profile/core/presentation/pages/profile_page.dart';
import 'package:wmd/features/settings/presentation/page/preferences_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  AppState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends AppState<SettingsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  int page = 0;

  @override
  void initState() {
    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: page,
    );
    _controller.addListener(() {
      setState(() {
        page = _controller.index;
        print(page);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    const double padding = 16;
    final appTheme = Theme.of(context);
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;
    final map = [
      MapEntry(
          appLocalizations.profile_tabs_personal_name, const ProfilePage()),
      MapEntry(appLocalizations.profile_tabs_preferences_name,
          const PreferencesPage()),
      MapEntry(
          appLocalizations.profile_tabs_linkedAccounts_name, const SizedBox()),
    ];
    return Theme(
      data: Theme.of(context).copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: appTheme.outlinedButtonTheme.style!.copyWith(
              minimumSize: MaterialStateProperty.all(const Size(0, 38))),
        ),
      ),
      child: Scaffold(
        appBar: const BaseAppBar(),
        body: Stack(
          children: [
            const LeafBackground(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (page != 1) const PrivacyBlurWarning(),
                Expanded(
                  child: isMobile
                      ? SettingsMobileView(
                          pages: map,
                          onPageOpened: (val) {
                            setState(() {
                              page = val;
                            });
                          })
                      : Padding(
                          padding: const EdgeInsets.all(padding),
                          child: SettingsTabletView(
                              pages: map,
                              onPageOpened: (val) {
                                setState(() {
                                  page = val;
                                });
                              }),
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTabletView extends StatefulWidget {
  const SettingsTabletView(
      {super.key, required this.pages, required this.onPageOpened});
  final List<MapEntry<String, Widget>> pages;
  final void Function(int page) onPageOpened;

  @override
  AppState<SettingsTabletView> createState() => _SettingsTabletViewState();
}

class _SettingsTabletViewState extends AppState<SettingsTabletView>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(
      length: widget.pages.length,
      vsync: this,
      initialIndex: 0,
    );
    _controller.addListener(() {
      widget.onPageOpened(_controller.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    const double padding = 16;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            appLocalizations.profile_tabs_heading,
            style: textTheme.headlineMedium,
          ),
        ),
        Row(
          children: [
            Builder(builder: (context) {
              final width = MediaQuery.of(context).size.width - padding * 2;
              return SizedBox(
                width: width,
                child: TabBar(
                  controller: _controller,
                  tabs: [
                    Tab(text: appLocalizations.profile_tabs_personal_name),
                    Tab(text: appLocalizations.profile_tabs_preferences_name),
                    Tab(
                        text:
                            appLocalizations.profile_tabs_linkedAccounts_name),
                  ],
                  isScrollable: true,
                  labelStyle: textTheme.bodySmall,
                  padding: const EdgeInsets.all(0),
                ),
              );
            }),
            const Spacer(),
          ],
        ),
        const Divider(
          height: 0.5,
          thickness: 0.5,
        ),
        Expanded(
            child: TabBarView(
          controller: _controller,
          children: [
            const ProfilePage(),
            const PreferencesPage(),
            Container(),
          ],
        )),
      ],
    );
  }
}

class SettingsMobileView extends AppStatelessWidget {
  const SettingsMobileView(
      {super.key, required this.pages, required this.onPageOpened});
  final List<MapEntry<String, Widget>> pages;
  final void Function(int page) onPageOpened;

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Text(
              appLocalizations.profile_tabs_heading,
              style: textTheme.headlineMedium,
            ),
          ),
          ...List.generate(pages.length, (index) {
            final e = pages[index];
            return ExpansionTile(
              title: Text(e.key),
              backgroundColor: AppColors.backgroundColorPageDark,
              children: [e.value],
              onExpansionChanged: (value) {
                if (value) {
                  onPageOpened(index);
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
