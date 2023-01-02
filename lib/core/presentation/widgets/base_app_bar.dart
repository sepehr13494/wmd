import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';
import 'package:wmd/core/util/app_theme.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const BaseAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [
        const ChangeLanguageButton(),
        // Switch(
        //     value: context.watch<ThemeManager>().state == ThemeMode.light,
        //     onChanged: (val) {
        //       context
        //           .read<ThemeManager>()
        //           .changeTheme(val ? ThemeMode.light : ThemeMode.dark);
        //     })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
