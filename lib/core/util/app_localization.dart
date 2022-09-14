import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationManager extends Cubit<Locale>{
  LocalizationManager() : super(AppLocalizations.supportedLocales.first);

  changeLang(Locale locale){
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