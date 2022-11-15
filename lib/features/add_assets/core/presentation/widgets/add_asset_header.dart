import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:wmd/features/authentication/login_signup/presentation/widgets/custom_app_bar.dart';

class AddAssetHeader extends StatelessWidget with PreferredSizeWidget {
  final Color? backgroundColor;
  final String title;
  const AddAssetHeader({Key? key, this.backgroundColor, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: false,
      title: Row(
        children: [
          const AppLogoWidget(),
          Expanded(
            child: Center(
              child: Text(title),
            ),
          ),
        ],
      ),
      actions: [
        const ChangeLanguageButton(),
        Switch(
            value: context.watch<ThemeManager>().state == ThemeMode.light,
            onChanged: (val) {
              context
                  .read<ThemeManager>()
                  .changeTheme(val ? ThemeMode.light : ThemeMode.dark);
            })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
