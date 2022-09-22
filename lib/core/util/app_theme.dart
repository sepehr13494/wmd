import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/local_storage.dart';

class ThemeManager extends Cubit<ThemeMode> {
  final LocalStorage localStorage;

  ThemeManager(this.localStorage) : super(ThemeMode.dark);

  changeTheme(ThemeMode themeMode) async {
    await localStorage.setTheme(themeMode);
    emit(themeMode);
  }
}

class AppThemes {
  AppThemes._();

  static ThemeData getAppTheme(BuildContext context,
      {required Brightness brightness}) {
    const primaryColor = AppColors.primary;
    return _appTheme(brightness: brightness).copyWith(
      textTheme: _appTheme(brightness: brightness).textTheme.apply(
          fontFamily: LocalizationManager.getFont(
              context.read<LocalizationManager>().state.languageCode)),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: primaryColor,
      ),

    );
  }

  static ThemeData _appTheme({required Brightness brightness}) {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
      ),
    );
  }
}
