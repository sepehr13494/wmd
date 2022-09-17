import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalStorage{
  final Box authBox;

  LocalStorage(this.authBox);

  Future<void> setTokenAndLogin(token) async {
    await authBox.put("token", "Bearer $token");
    await authBox.put("isLogin", true);
  }

  Future<void> logout() async {
    authBox.clear();
  }

  String getToken() {
    return authBox.get("token",defaultValue: "");
  }

  Future<bool> getLogin() async{
    return authBox.get("isLogin",defaultValue: false);
  }

  ThemeMode getTheme() {
    final result = authBox.get("themeMode",defaultValue: "dark");
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
    await authBox.put("themeMode",theme);
  }

  Locale getLocale() {
    final result = authBox.get("locale",defaultValue: "en");
    return AppLocalizations.supportedLocales.firstWhere((element) => element.languageCode == result);
  }

  Future<void> setLocale(Locale locale) async{
    await authBox.put("locale",locale.languageCode);
  }
}