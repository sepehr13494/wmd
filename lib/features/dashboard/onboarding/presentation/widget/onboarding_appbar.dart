import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingAppBar extends StatelessWidget with PreferredSizeWidget {
  final int page;
  final bool isAsset;

  const OnboardingAppBar({Key? key, this.isAsset = false, this.page = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final bottom = AppBar(
      centerTitle: false,
      title: Row(
        children: isAsset
            ? [
                const SizedBox(width: 16),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      shape: BoxShape.circle,
                      color: page == 1
                          ? Theme.of(context).primaryColor
                          : AppColors.dashBoardGreyTextColor),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "1",
                          style: TextStyle(
                              color: AppColors.backgroundColorPageDark),
                        )
                      ]),
                ),
                const SizedBox(width: 12),
                if (page == 1)
                  Text(
                      appLocalizations
                          .common_guidedOnBoardingModalStepper_selectAsset_title,
                      style: textTheme.titleSmall),
                const SizedBox(width: 16),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      shape: BoxShape.circle,
                      color: page == 2
                          ? Theme.of(context).primaryColor
                          : AppColors.dashBoardGreyTextColor),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "2",
                          style: TextStyle(
                              color: AppColors.backgroundColorPageDark),
                        )
                      ]),
                ),
                const SizedBox(width: 12),
                if (page == 2)
                  Text(
                      appLocalizations
                          .common_guidedOnBoardingModalStepper_firstAsset_title,
                      style: textTheme.titleSmall),
                const SizedBox(width: 16),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      shape: BoxShape.circle,
                      color: page == 3
                          ? Theme.of(context).primaryColor
                          : AppColors.dashBoardGreyTextColor),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "3",
                          style: TextStyle(
                              color: AppColors.backgroundColorPageDark),
                        )
                      ]),
                ),
              ]
            : [],
      ),
    );

    if (isAsset) {
      return AppBar(
        title: Row(
          mainAxisAlignment:
              isAsset ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                context.goNamed(AppRoutes.onboarding);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            const ChangeLanguageButton(),
          ],
        ),
        bottom: bottom,
      );
    }

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          ChangeLanguageButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return isAsset ? const Size.fromHeight(100) : const Size.fromHeight(60);
  }
}
