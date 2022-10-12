import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/util/app_localization.dart';

class TermsAndConditions{

  static const String englishTerms = '''''';

  static const String arabicTerms = '''''';

  static String getTerm(BuildContext context){
    switch (context.read<LocalizationManager>().state.languageCode){
      case "en":
        return englishTerms;
      case "ar":
        return arabicTerms;
      default:
        return englishTerms;
    }
  }
}