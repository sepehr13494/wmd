import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/dashboard_main_page.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/pages/dashboard_page.dart';
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
    const DashboardPage(),
  ];

  static final List<List> items = [
    [Icons.home, 'Home'],
    [Icons.account_box, 'Main'],
  ];

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => sl<MainPageCubit>()..initMainScreen(context),
  child: Builder(
    builder: (context) {
      return BlocBuilder<MainPageCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body:  DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('برای خروج دوباره کلیک کنید'),
            ),
            child: Center(
              child: _widgetOptions.elementAt(state),
            ),
          ),
          bottomNavigationBar: Material(
            elevation: 10,
            child: Container(
              color: Theme.of(context).navigationBarTheme.backgroundColor,
              child: BottomNavigationBar(
                elevation: 0,
                items: List.generate(items.length, (index) {
                  return BottomNavigationBarItem(
                    icon: Icon(items[index][0]),
                    label: items[index][1],
                  );
                }),
                unselectedLabelStyle:
                const TextStyle(fontSize: 10, color: Colors.black),
                selectedLabelStyle:
                const TextStyle(fontSize: 12, color: Colors.black),
                currentIndex: state,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                onTap: context.read<MainPageCubit>().onItemTapped,
              ),
            ),
          ),
        );
      },
);
    }
  ),
);
  }
}
