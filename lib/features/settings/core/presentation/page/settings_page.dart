import 'package:advance_expansion_tile/advance_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/base_app_bar.dart';
import 'package:wmd/core/presentation/widgets/leaf_background.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/profile/core/presentation/pages/profile_page.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/presentation/widgets/two_factor_settings_widget.dart';
import 'package:wmd/features/settings/linked_accounts/presentation/page/linked_accounts_page.dart';
import 'package:wmd/features/settings/preferences/presentation/page/preferences_page.dart';

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
      });
    });

    context.read<TwoFactorCubit>().getTwoFactor();

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
    final List<MapEntry<String, Widget>> map = [
      MapEntry(
          appLocalizations.profile_tabs_personal_name, const ProfilePage()),
    ];
    if (isMobile) {
      map.add(MapEntry(
          appLocalizations.profile_twoFactor_header,
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const TwoFactorSetting(),
              ],
            ),
          )));
    }

    map.add(MapEntry(appLocalizations.profile_tabs_preferences_name,
        const PreferencesPage()));
    map.add(MapEntry(
      appLocalizations.profile_tabs_linkedAccounts_name,
      const LinkedAccountsPage(),
    ));

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
                // if (page != 1)
                //   const Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 8),
                //     child: PrivacyBlurWarning(),
                //   ),
                Expanded(
                  child: isMobile
                      ? SettingsMobileView(
                          pages: map,
                          onPageOpened: (val) {
                            setState(() {
                              page = val;
                            });
                          },
                        )
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
                  tabs: widget.pages.map((e) => Tab(text: e.key)).toList(),
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
          children: widget.pages.map((e) => e.value).toList(),
        )),
      ],
    );
  }
}

class SettingsMobileView extends StatefulWidget {
  const SettingsMobileView(
      {super.key, required this.pages, required this.onPageOpened});
  final List<MapEntry<String, Widget>> pages;
  final void Function(int page) onPageOpened;

  @override
  AppState<SettingsMobileView> createState() => _SettingsMobileViewState();
}

class _SettingsMobileViewState extends AppState<SettingsMobileView> {
  late final List<GlobalKey<AdvanceExpansionTileState>> keys;

  @override
  void initState() {
    super.initState();
    keys = List.generate(
        widget.pages.length, (index) => GlobalKey<AdvanceExpansionTileState>());
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16),
              child: Text(
                appLocalizations.profile_tabs_heading,
                style: textTheme.headlineMedium,
              ),
            ),
          ),
          ...List.generate(widget.pages.length, (index) {
            final e = widget.pages[index];
            return AdvanceExpansionTile(
              key: keys[index],
              title: Text(e.key),
              textColor: Colors.white,
              collapsedTextColor: Colors.white,
              collapsedIconColor: Theme.of(context).primaryColor,
              iconColor: Theme.of(context).primaryColor,
              backgroundColor: AppColors.backgroundColorPageDark,
              children: [e.value],
              onExpansionChanged: (value) {
                if (value) {
                  setPanels(index);
                  widget.onPageOpened(index);
                }
              },
            );
          }),
        ],
      ),
    );
  }

  setPanels(int index) {
    for (var i = 0; i < keys.length; i++) {
      if (i != index) {
        keys[i].currentState?.collapse();
      }
    }
  }
}
