import 'package:flutter/material.dart';

Color primaryColor = Colors.blue;
ThemeData appThemeLight =
    ThemeData.light().copyWith(primaryColor: primaryColor);
ThemeData appThemeDark = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  colorScheme: ColorScheme.dark(primary: primaryColor),
);
