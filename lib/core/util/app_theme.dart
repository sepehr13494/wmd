import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_localization.dart';
import 'colors.dart';
import 'local_storage.dart';

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
    final ThemeData appTheme = _appTheme(brightness: brightness);
    final TextTheme textTheme = appTheme.textTheme;
    final Color textColor = textTheme.bodySmall?.color ??
        (brightness == Brightness.dark ? Colors.white : Colors.black54);
    return appTheme.copyWith(
        textTheme: appTheme.textTheme.apply(
          fontFamily: LocalizationManager.getFont(
              context.read<LocalizationManager>().state.languageCode),
        ),
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: brightness == Brightness.dark
              ? AppColors.backgroundColorPageDark
              : Colors.white,
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
        scaffoldBackgroundColor: brightness == Brightness.dark
            ? AppColors.backgroundColorPageDark
            : Colors.white,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(textColor),
            minimumSize:
                MaterialStateProperty.all(const Size(double.maxFinite, 48)),
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: textColor)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.maxFinite, 48)),
          backgroundColor: MaterialStateProperty.all(primaryColor),
        )),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          border: OutlineInputBorder(),
        ),
        dividerColor: textColor,
        listTileTheme: const ListTileThemeData(
          horizontalTitleGap: 0,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(primaryColor),
          checkColor:
              MaterialStateProperty.all(appTheme.scaffoldBackgroundColor),
        ));
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
