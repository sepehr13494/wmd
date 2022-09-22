import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/util/app_theme.dart';
import 'package:wmd/core/util/local_storage.dart';

import 'theme_manager_test.mocks.dart';

@GenerateMocks([LocalStorage])
void main(){
  const testThemeMode = ThemeMode.light;
  late ThemeManager themeManager;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    themeManager = ThemeManager(mockLocalStorage);
  });
  test("initial state is ThemeMode", () {
    //arrange
    //act
    //assert
    expect(themeManager.state, isA<ThemeMode>());
  });

  blocTest(
    'emits the theme when changeTheme is called',
    setUp: () => when(mockLocalStorage.setTheme(testThemeMode)).thenAnswer((realInvocation) async => 0),
    build: () => themeManager,
    act: (bloc)=>bloc.changeTheme(testThemeMode),
    verify: (_)=>verify(mockLocalStorage.setTheme(testThemeMode)),
    expect: () => [testThemeMode],
  );
}