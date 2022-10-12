import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'local_storage_test.mocks.dart';



void main(){
  final testLocale = AppLocalizations.supportedLocales.first;
  late LocalizationManager localizationManager;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    localizationManager = LocalizationManager(mockLocalStorage);
  });

  test("initial state is Locale", () {
    //arrange
    //act
    //assert
    expect(localizationManager.state, isA<Locale>());
  });

  blocTest(
    'emits the locale when changeLang is called',
    setUp: () => when(mockLocalStorage.setLocale(testLocale)).thenAnswer((realInvocation) async => 0),
    build: () => localizationManager,
    act: (bloc)=>bloc.changeLang(testLocale),
    verify: (_)=>verify(mockLocalStorage.setLocale(testLocale)),
    expect: () => [testLocale],
  );
}