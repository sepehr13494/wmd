import 'dart:developer';
import 'dart:io' show Platform;
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

import 'package:wmd/features/assets_overview/assets_overview/presentation/pages/assets_overview_page.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/dashboard_main_page.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

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
      [Icons.home, appLocalizations.common_nav_links_home],
      [Icons.bar_chart, appLocalizations.common_nav_links_assets],
    ];

    final List<Widget> widgetOptions = <Widget>[
      DashboardMainPage(expandCustodian: widget.expandCustodian),
      const AssetsOverView(),
    ];

    return Builder(builder: (context) {
      return BlocBuilder<MainPageCubit, int>(
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
                                      icon: Icon(items[index][0]),
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
      );
    });
  }
}
