import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/pages/assets_overview_page.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/dashboard_main_page.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/language_patcher/presentation/page/language_patcher.dart';
import 'package:wmd/features/liability_overview/presentation/page/liability_overview_page.dart';

import '../manager/main_page_cubit.dart';

class MainPage extends StatefulWidget {
  final bool expandCustodian;

  const MainPage({Key? key, this.expandCustodian = false}) : super(key: key);

  @override
  AppState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends AppState<MainPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<UserStatusCubit>().getUserStatus();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final List<List> items = [
      [
        "assets/images/home_icon.svg",
        appLocalizations.common_nav_links_home,
        "assets/images/home_icon_filled.svg"
      ],
      [
        "assets/images/assets_icon.svg",
        appLocalizations.common_nav_links_assets,
        "assets/images/assets_icon_filled.svg"
      ],
      if (!AppConstants.isRelease1)
        [
          "assets/images/liability_disabled.svg",
          appLocalizations.common_nav_links_liabilities,
          "assets/images/liability_active.svg"
        ],
    ];

    final List<Widget> widgetOptions = <Widget>[
      DashboardMainPage(expandCustodian: widget.expandCustodian),
      const AssetsOverView(),
      if (!AppConstants.isRelease1) const LiabilityOverviewPage(),
    ];

    return LanguagePatcher(
      child: BlocBuilder<MainPageCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: state == 0
                ? DoubleBackToCloseApp(
                    snackBar: const SnackBar(
                      content: Text('for exit click again'),
                    ),
                    child: Center(
                      child: widgetOptions.elementAt(state),
                    ),
                  )
                : Center(
                    child: widgetOptions.elementAt(state),
                  ),
            bottomNavigationBar: BlocConsumer<MainDashboardCubit,
                    MainDashboardState>(
                listener: BlocHelper.defaultBlocListener(
                    listener: (mainContext, mainState) {}),
                builder: (mainContext, mainState) {
                  context
                      .read<CustodianStatusListCubit>()
                      .getCustodianStatusList();
                  return mainState is MainDashboardNetWorthLoaded
                      ? (mainState.netWorthObj.assets.currentValue != 0 ||
                              mainState.netWorthObj.liabilities.currentValue !=
                                  0)
                          ? Material(
                              elevation: 10,
                              child: Container(
                                color: Theme.of(context)
                                    .navigationBarTheme
                                    .backgroundColor,
                                child: BottomNavigationBar(
                                  elevation: 0,
                                  items: List.generate(items.length, (index) {
                                    return BottomNavigationBarItem(
                                      icon: SvgPicture.asset(
                                          items[index][0] as String),
                                      activeIcon: SvgPicture.asset(
                                          items[index][2] as String),
                                      label: items[index][1],
                                    );
                                  }),
                                  unselectedLabelStyle:
                                      const TextStyle(fontSize: 10),
                                  selectedLabelStyle:
                                      const TextStyle(fontSize: 12),
                                  currentIndex:
                                      context.read<MainPageCubit>().state,
                                  showUnselectedLabels: true,
                                  type: BottomNavigationBarType.fixed,
                                  onTap: context
                                      .read<MainPageCubit>()
                                      .onItemTapped,
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                      : const SizedBox.shrink();
                }),
          );
        },
      ),
    );
  }
}
