import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/pages/assets_overview_page.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/dashboard_main_page.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/dashboard_page.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../manager/main_page_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardMainPage(),
    const AssetsOverView(),
  ];

  static final List<List> items = [
    [Icons.home, 'Home'],
    [Icons.bar_chart, 'Assets'],
  ];

  @override
  void initState() {
    context.read<UserStatusCubit>().getUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MainPageCubit>(),
      child: Builder(builder: (context) {
        return BlocBuilder<MainPageCubit, int>(
          builder: (context, state) {
            return Scaffold(
              body: DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text('for exit click again'),
                ),
                child: Center(
                  child: _widgetOptions.elementAt(state),
                ),
              ),
              bottomNavigationBar: Material(
                elevation: 10,
                child: Container(
                  color: Theme
                      .of(context)
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
                    unselectedLabelStyle: const TextStyle(fontSize: 10),
                    selectedLabelStyle: const TextStyle(fontSize: 12),
                    currentIndex: state,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    onTap: context
                        .read<MainPageCubit>()
                        .onItemTapped,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
