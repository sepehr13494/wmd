import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'local_storage.dart';

class LocalizationManager extends Cubit<Locale> {
  final LocalStorage localStorage;
  LocalizationManager(this.localStorage)
      : super(AppLocalizations.supportedLocales
            .firstWhere((element) => element.languageCode == "en"));

  changeLang(Locale locale) async {
    await localStorage.setLocale(locale);
    emit(locale);
  }

  static getFont(String languageCode) {
    switch (languageCode) {
      case "en":
        return "gotham";
      default:
        return "Almarai";
    }
  }

  static String getNameFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case "en":
        return "English";
      case "ar":
        return "عربی";
      default:
        return "English";
    }
  }

  static String getNameFromShortName(String shortName) {
    switch (shortName) {
      case "en":
        return "English";
      case "ar":
        return "عربی";
      default:
        return "English";
    }
  }

  getOtherName(context) {
    return (state.languageCode == "en")
        ? SvgPicture.asset(
            "assets/images/arabic_icon.svg",
            // height: 50,
          )
        : Text(
            "English",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Theme.of(context).primaryColor),
          );
  }

  getName() {
    return (state.languageCode == "en") ? "English" : "عربی";
  }

  switchLanguage() {
    changeLang(state.languageCode == "en"
        ? AppLocalizations.supportedLocales
            .firstWhere((element) => element.languageCode == "ar")
        : AppLocalizations.supportedLocales
            .firstWhere((element) => element.languageCode == "en"));
  }
}
