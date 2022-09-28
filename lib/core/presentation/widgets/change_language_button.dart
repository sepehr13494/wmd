import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationManager, Locale>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            context.read<LocalizationManager>().changeLang(
                state.languageCode == "en"
                    ? AppLocalizations.supportedLocales
                        .firstWhere((element) => element.languageCode == "ar")
                    : AppLocalizations.supportedLocales
                        .firstWhere((element) => element.languageCode == "en"));
          },
          child: Text(
            (state.languageCode == "en") ? "عربی" : "English",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Theme.of(context).primaryColor),
          ),
        );
      },
    );
  }
}
