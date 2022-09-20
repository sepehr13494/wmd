import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main(){
  final testLocale = AppLocalizations.supportedLocales.first;

  test("initial state is Locale", () {
    //arrange
    final localizationManager = LocalizationManager();
    //act
    //assert
    expect(localizationManager.state, isA<Locale>());
  });

  blocTest(
    'emits the locale when changeLang is called',
    build: () => LocalizationManager(),
    act: (bloc)=>bloc.changeLang(testLocale),
    expect: () => [testLocale],
  );
}