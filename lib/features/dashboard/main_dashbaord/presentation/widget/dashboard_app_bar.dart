import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_restart.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_toggle.dart';

class DashboardAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool? showHelp;
  final bool? showBack;
  final VoidCallback? handleGoBack;

  const DashboardAppBar(
      {Key? key,
      this.showHelp = true,
      this.showBack = false,
      this.handleGoBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBack == true
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primary,
              ),
              onPressed: () {
                if (handleGoBack != null) {
                  handleGoBack!();
                }
              },
            )
          : null,
      centerTitle: false,
      title: showBack == true
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: IconButton(
                iconSize: 150,
                icon: SvgPicture.asset(
                  "assets/images/app_logo.svg",
                  // height: 50,
                ),
                onPressed: () {
                  if (handleGoBack != null && showBack == true) {
                    handleGoBack!();
                  }
                },
              ))
          : Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SvgPicture.asset(
                "assets/images/app_logo.svg",
                height: 50,
              )),
      actions: [
        // const PrivacyToggle(),
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
            onPressed: () => context.pushNamed(AppRoutes.support),
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
                CustomIcons.logout
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
                            AppRestart.restart(context);
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
