import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_theme.dart';

class CustomAuthAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color? backgroundColor;
  final bool automaticallyImplyLeading;
  const CustomAuthAppBar(
      {Key? key, this.backgroundColor, this.automaticallyImplyLeading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: false,
      automaticallyImplyLeading: automaticallyImplyLeading,
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

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/logo.svg",
      height: 35,
    );
  }
}
