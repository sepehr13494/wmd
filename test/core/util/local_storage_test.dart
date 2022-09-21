import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/util/local_storage.dart';

import 'local_storage_test.mocks.dart';

@GenerateMocks([Box])
void main(){
  late MockBox mockAuthBox;
  late LocalStorage localStorage;
  
  setUp(() {
    mockAuthBox = MockBox();
    localStorage = LocalStorage(mockAuthBox);
  });
  
  group('authentication part', () {
    String tToken = "token";
    test('set token and isLogin',() async {
        //arrange
        //act
        await localStorage.setTokenAndLogin(tToken);
        //assert
        verify(mockAuthBox.put(LocalStorage.appToken,"Bearer $tToken"));
        verify(mockAuthBox.put(LocalStorage.appIsLogin,true));
    });

    test('logout',() async {
      //arrange
      when(mockAuthBox.clear()).thenAnswer((realInvocation) async => 0);
      //act
      await localStorage.logout();
      //assert
      verify(mockAuthBox.clear());
    });

    test('get token',(){
      //arrange
      when(mockAuthBox.get(LocalStorage.appToken,defaultValue: anyNamed("defaultValue"))).thenAnswer((realInvocation) => tToken);
      //act
      final result = localStorage.getToken();
      //assert
      expect(result, tToken);
      verify(mockAuthBox.get(LocalStorage.appToken,defaultValue: ""));
    });
  });

  group('theme part', () {
    ThemeMode tThemeMode = ThemeMode.dark;
    String tThemeString = "dark";
    test('set theme',(){
      //arrange
      //act
      localStorage.setTheme(tThemeMode);
      //assert
      verify(mockAuthBox.put(LocalStorage.appThemeMode,tThemeString));
    });

    test('get theme',(){
      //arrange
      when(mockAuthBox.get(LocalStorage.appThemeMode,defaultValue: anyNamed("defaultValue"))).thenAnswer((realInvocation) => tThemeString);
      //act
      final result = localStorage.getTheme();
      //assert
      verify(mockAuthBox.get(LocalStorage.appThemeMode,defaultValue: "dark"));
      expect(result, tThemeMode);
    });
  });

  group('theme part', () {
    Locale tLocale = const Locale("en");
    String tLocaleString = "en";
    test('set locale',(){
      //arrange
      //act
      localStorage.setLocale(tLocale);
      //assert
      verify(mockAuthBox.put(LocalStorage.appLocale,tLocaleString));
    });

    test('get locale',(){
      //arrange
      when(mockAuthBox.get(LocalStorage.appLocale,defaultValue: anyNamed("defaultValue"))).thenAnswer((realInvocation) => tLocaleString);
      //act
      final result = localStorage.getLocale();
      //assert
      verify(mockAuthBox.get(LocalStorage.appLocale,defaultValue: "en"));
      expect(result, tLocale);
    });
  });
}