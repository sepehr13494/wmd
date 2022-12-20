import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/onboarding/presentation/widget/onboarding_appbar.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/injection_container.dart';

class AddAssetHeader extends StatelessWidget with PreferredSizeWidget {
  final Color? backgroundColor = AppColors.cardColor;
  final String title;
  const AddAssetHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sl<GetUserStatusUseCase>().showOnboarding) {
      return const OnboardingAppBar(page: 2, isAsset: true);
    } else {
      return AppBar(
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.arrow_back_ios,
                  size: 10,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Back",
                  style: TextStyle(color: AppColors.primary, fontSize: 16),
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
