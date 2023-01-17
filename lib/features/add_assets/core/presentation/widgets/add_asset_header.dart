import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/onboarding_appbar.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/global_functions.dart';

class AddAssetHeader extends StatelessWidget with PreferredSizeWidget {
  final Color? backgroundColor = AppColors.cardColor;
  final String title;
  final bool considerFirstTime;
  const AddAssetHeader(
      {Key? key, required this.title, this.considerFirstTime = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sl<GetUserStatusUseCase>().showOnboarding && considerFirstTime) {
      return const OnboardingAppBar(page: 2, isAsset: true);
    } else {
      return AppBar(
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  size: 10,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context).common_button_back,
                  style:
                      const TextStyle(color: AppColors.primary, fontSize: 16),
                )
              ],
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        title: Text(title),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
