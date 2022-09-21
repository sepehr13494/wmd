import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalStorage{
  final Box authBox;

  LocalStorage(this.authBox);

  static const appToken = "token";
  static const appIsLogin = "isLogin";
  static const appThemeMode = "themeMode";
  static const appLocale = "locale";

  Future<void> setTokenAndLogin(token) async {
    await authBox.put(appToken, "Bearer $token");
    await authBox.put(appIsLogin, true);
  }

  Future<void> logout() async {
    await authBox.clear();
  }

  String getToken() {
    return authBox.get(appToken,defaultValue: "");
  }

  Future<bool> getLogin() async{
    return authBox.get(appIsLogin,defaultValue: false);
  }

  ThemeMode getTheme() {
    final result = authBox.get(appThemeMode,defaultValue: "dark");
    switch (result){
      case "dark":
        return ThemeMode.dark;
      case "light":
        return ThemeMode.light;
      case "system":
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async{
    String theme = themeMode.toString().replaceAll("ThemeMode.", "");
    await authBox.put(appThemeMode,theme);
  }

  Locale getLocale() {
    final result = authBox.get(appLocale,defaultValue: "en");
    return AppLocalizations.supportedLocales.firstWhere((element) => element.languageCode == result);
  }

  Future<void> setLocale(Locale locale) async{
    await authBox.put(appLocale,locale.languageCode);
  }
}