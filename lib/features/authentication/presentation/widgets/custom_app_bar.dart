import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/change_language_button.dart';

class CustomAuthAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color? backgroundColor;
  const CustomAuthAppBar({Key? key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Image.asset(
        "assets/images/logo.png",
        height: 60,
      ),
      actions: const [ChangeLanguageButton()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
