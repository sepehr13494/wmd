import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/app_localization.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: AppLocalizations.supportedLocales
            .map((e) => DropdownMenuItem(value: e,child: Text(e.countryCode??""),)).toList(),
        onChanged: (val) {
          if(val != null){
            context.read<LocalizationManager>().changeLang(val);
          }
        },hint: const Icon(Icons.language));
  }
}
