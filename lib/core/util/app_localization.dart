import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';

class LocalizationManager extends Cubit<Locale>{
  final LocalStorage localStorage;
  LocalizationManager(this.localStorage) : super(AppLocalizations.supportedLocales.first);

  changeLang(Locale locale) async {
    await localStorage.setLocale(locale);
    emit(locale);
  }

  static getFont(String languageCode){
    switch (languageCode){
      case "en" :
        return "NunitoSans";
      case "fa" :
        return "IranSans";
      default:
        return "IranSans";
    }
  }
}