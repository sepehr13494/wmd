import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/core/util/app_theme.dart';

void main(){
  const testThemeMode = ThemeMode.light;

  test("initial state is ThemeMode", () {
    //arrange
    final themeManager = ThemeManager();
    //act
    //assert
    expect(themeManager.state, isA<ThemeMode>());
  });

  blocTest(
    'emits the theme when changeTheme is called',
    build: () => ThemeManager(),
    act: (bloc)=>bloc.changeTheme(testThemeMode),
    expect: () => [testThemeMode],
  );
}