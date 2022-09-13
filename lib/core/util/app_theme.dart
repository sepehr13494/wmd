import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/util/colors.dart';

class ThemeManager extends Cubit<ThemeData>{
  ThemeManager() : super(AppThemes.darkTheme);

  changeTheme(ThemeData theme){
    emit(theme);
  }
}

class AppThemes {

  AppThemes._();

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary
  );

  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary
  );
}