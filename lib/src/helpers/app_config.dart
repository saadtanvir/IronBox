import 'package:flutter/material.dart';
import 'app_constants.dart' as Constants;

class AppTheme {
  ThemeData _appLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Constants.primaryColor,
    accentColor: Constants.accentColor,
    secondaryHeaderColor: Constants.secondaryColor,
    focusColor: Constants.primaryColor,
    scaffoldBackgroundColor: Constants.scaffoldColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Constants.primaryColor),
    appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        actionsIconTheme:
            IconThemeData(color: Colors.black, size: Constants.appBarIconSize)),
  );

  AppTheme();

  ThemeData getAppTheme() {
    return _appLightTheme;
  }
}
