import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/util/app_localization.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationManager, Locale>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<LocalizationManager>().switchLanguage();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: context.read<LocalizationManager>().getOtherName(context),
            ),
          ),
        );
      },
    );
  }
}
