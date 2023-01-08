import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/injection_container.dart';

class DashboardAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool? showHelp;
  const DashboardAppBar({Key? key, this.showHelp = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      actions: [
        const ChangeLanguageButton(),
        // Switch(
        //     value: context.watch<ThemeManager>().state == ThemeMode.light,
        //     onChanged: (val) {
        //       context
        //           .read<ThemeManager>()
        //           .changeTheme(val ? ThemeMode.light : ThemeMode.dark);
        //     }),
        if (showHelp == true)
          IconButton(
            onPressed: () => context.goNamed(AppRoutes.support),
            icon: SvgPicture.asset("assets/images/add_assets/question.svg"),
          ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            final List items = [
              ["Profile", Icons.arrow_forward_ios_rounded],
              ["Logout", Icons.logout],
            ];
            return List.generate(
                items.length,
                (index) => PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(items[index][0]),
                          Icon(
                            items[index][1],
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          )
                        ],
                      ),
                      onTap: () {
                        switch (index) {
                          case 0:
                            context.goNamed(AppRoutes.settings);
                            break;
                          case 1:
                            sl<LocalStorage>().logout();
                            context.replaceNamed(AppRoutes.splash);
                            break;
                        }
                      },
                    ));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.settings),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
