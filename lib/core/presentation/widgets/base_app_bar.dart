import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_restart.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_toggle.dart';
import '../routes/app_routes.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool? enableLogoAction;
  final bool enableActions;
  final VoidCallback? onLogoPress;

  const BaseAppBar(
      {Key? key,
      this.enableLogoAction = false,
      this.onLogoPress,
      this.enableActions = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: enableLogoAction == true
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: IconButton(
                iconSize: 150,
                icon: SvgPicture.asset(
                  "assets/images/app_logo.svg",
                  // height: 50,
                ),
                onPressed: () {
                  if (onLogoPress != null) onLogoPress!();
                  context.goNamed(AppRoutes.main);
                },
              ))
          : Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SvgPicture.asset(
                "assets/images/app_logo.svg",
                height: 50,
              )),
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
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).maybePop();
              } else {
                context.goNamed(AppRoutes.main);
              }
              // GlobalFunctions.showExitDialog(
              //     context: context,
              //     onExitClick: () {

              //     });
            }
          } catch (e) {
            debugPrint("footer error$e");
            context.goNamed(AppRoutes.main);
          }
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: !enableActions
          ? null
          : [
              const PrivacyToggle(),
              const ChangeLanguageButton(),
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
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                )
                              ],
                            ),
                            onTap: () {
                              switch (index) {
                                case 0:
                                  context.pushNamed(AppRoutes.settings);
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
