import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/colors.dart';

class ThemeManager extends Cubit<ThemeMode> {
  ThemeManager() : super(ThemeMode.dark);

  changeTheme(ThemeMode themeMode) {
    emit(themeMode);
  }
}

class AppThemes {
  AppThemes._();

  static ThemeData getAppTheme(BuildContext context,
      {required Brightness brightness}) {
    return _appTheme(brightness: brightness).copyWith(
        textTheme: _appTheme(brightness: brightness).textTheme.apply(
            fontFamily: LocalizationManager.getFont(context
                .read<LocalizationManager>()
                .state
                .languageCode))
    );
  }

  static ThemeData _appTheme({required Brightness brightness}) {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary, brightness: brightness),
    );
  }
}
