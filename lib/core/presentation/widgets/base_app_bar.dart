import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/global_functions.dart';
import 'package:wmd/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../routes/app_routes.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  const BaseAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          // context.goNamed(AppRoutes.main);
          try {
            if (GoRouter.of(context).location ==
                "/${AppRoutes.addAssetsView}") {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).maybePop();
              } else {
                context.goNamed(AppRoutes.main);
              }
            } else {
              GlobalFunctions.showExitDialog(
                  context: context,
                  onExitClick: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).maybePop();
                    } else {
                      context.goNamed(AppRoutes.main);
                    }
                  });
            }
          } catch (e) {
            debugPrint("footer error$e");
            context.goNamed(AppRoutes.main);
          }
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        const ChangeLanguageButton(),
        // Switch(
        //     value: context.watch<ThemeManager>().state == ThemeMode.light,
        //     onChanged: (val) {
        //       context
        //           .read<ThemeManager>()
        //           .changeTheme(val ? ThemeMode.light : ThemeMode.dark);
        //     }),

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
