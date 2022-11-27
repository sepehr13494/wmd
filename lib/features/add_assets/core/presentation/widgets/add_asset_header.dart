import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';

class AddAssetHeader extends StatelessWidget with PreferredSizeWidget {
  final Color? backgroundColor = AppColors.cardColor;
  final String title;
  const AddAssetHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
