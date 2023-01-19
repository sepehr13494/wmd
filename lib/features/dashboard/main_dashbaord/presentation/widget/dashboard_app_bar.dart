import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              [
                AppLocalizations.of(context).profile_page_title,
                Icons.arrow_forward_ios_rounded
              ],
              [
                AppLocalizations.of(context)
                    .profile_changePassword_button_logout,
                Icons.logout
              ],
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
                            Restart.restartApp();
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
