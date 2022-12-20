import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';
import 'package:wmd/injection_container.dart';

class OnboardingAppBar extends StatelessWidget with PreferredSizeWidget {
  final int page;
  final bool isAsset;

  const OnboardingAppBar({Key? key, this.isAsset = false, this.page = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
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
                  Text("Select assets", style: textTheme.titleSmall),
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
                  Text("Add your first asset", style: textTheme.titleSmall),
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
