import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'local_storage.dart';
import '../../injection_container.dart';

class LocalizationManager extends Cubit<Locale> {
  final LocalStorage localStorage;
  LocalizationManager(this.localStorage)
      : super(AppLocalizations.supportedLocales.first);

  changeLang(Locale locale) async {
    await localStorage.setLocale(locale);
    emit(locale);
  }

  static getFont(String languageCode) {
    switch (languageCode) {
      case "en":
        return "gotham";
      default:
        return "IranSans";
    }
  }

  getName() {
    return (state.languageCode == "en") ? "عربی" : "English";
  }

  switchLanguage(){
    changeLang(
    state.languageCode == "en"
    ? AppLocalizations.supportedLocales
        .firstWhere((element) => element.languageCode == "ar")
        : AppLocalizations.supportedLocales
        .firstWhere((element) => element.languageCode == "en"));
  }
}
