import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/change_language_button.dart';

class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset("assets/images/logo.png"),
      actions: const [
        ChangeLanguageButton()
      ],
    );
  }
}
