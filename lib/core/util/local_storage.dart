import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../error_and_success/exeptions.dart';

class LocalStorage {
  final Box authBox;

  LocalStorage(this.authBox);

  static const appToken = "token";
  static const appRefreshToken = "refreshToken";
  static const appIsLogin = "isLogin";
  static const appThemeMode = "themeMode";
  static const appLocale = "locale";
  static const ownerId = "ownerId";
  static const localAuth = "localAuth";

  Future<void> setTokenAndLogin(token) async {
    try {
      await authBox.put(appToken, "Bearer $token");
      await authBox.put(appIsLogin, true);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> setOwnerId(val) async {
    try {
      await authBox.put(ownerId, val);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  String getOwnerId() {
    try {
      return authBox.get(ownerId, defaultValue: "");
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> setLocalAuth(val) async {
    try {
      await authBox.put(localAuth, val);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  bool getLocalAuth() {
    try {
      return authBox.get(localAuth, defaultValue: false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> setRefreshToken(token) async {
    try {
      await authBox.put(appRefreshToken, token);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  String getRefreshToken() {
    try {
      return authBox.get(appRefreshToken, defaultValue: "");
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await authBox.clear();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  String getToken() {
    try {
      return authBox.get(appToken, defaultValue: "");
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<bool> getLogin() async {
    try {
      return authBox.get(appIsLogin, defaultValue: false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  ThemeMode getTheme() {
    final result = authBox.get(appThemeMode, defaultValue: "dark");
    switch (result) {
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

  Future<void> setTheme(ThemeMode themeMode) async {
    try {
      String theme = themeMode.toString().replaceAll("ThemeMode.", "");
      await authBox.put(appThemeMode, theme);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Locale getLocale() {
    try {
      final result = authBox.get(appLocale, defaultValue: "en");
      return AppLocalizations.supportedLocales
          .firstWhere((element) => element.languageCode == result);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<void> setLocale(Locale locale) async {
    try {
      await authBox.put(appLocale, locale.languageCode);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
