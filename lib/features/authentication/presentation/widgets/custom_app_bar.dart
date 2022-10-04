import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_theme.dart';

class CustomAuthAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color? backgroundColor;
  final bool showBackIcon;
  const CustomAuthAppBar(
      {Key? key, this.backgroundColor, this.showBackIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: (showBackIcon
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () => GoRouter.of(context).pop(),
            )
          : null),
      automaticallyImplyLeading: showBackIcon,
      title: SvgPicture.asset(
        "assets/images/logo.svg",
        height: 36,
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
