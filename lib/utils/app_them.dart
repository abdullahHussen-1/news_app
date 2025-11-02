import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_style.dart';

class AppThem {
  static final ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryLightMode,
    hintColor: AppColors.primaryDarkMode,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLightMode,
      iconTheme: IconThemeData(color: AppColors.primaryDarkMode),
    ),
    textTheme: TextTheme(
      labelSmall: AppStyle.medium20whit,
      bodyLarge: AppStyle.medium16dark,
      labelLarge: AppStyle.bold16black,
      headlineMedium: AppStyle.medium14dark,
      headlineLarge: AppStyle.medium24dark,
      bodyMedium: AppStyle.medium24wight,
      bodySmall: AppStyle.medium20dark,
      displayLarge: AppStyle.medium14wight,
    ),
  );
  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryDarkMode,
    hintColor: AppColors.primaryLightMode,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDarkMode,
      iconTheme: IconThemeData(color: AppColors.primaryLightMode),
    ),

    textTheme: TextTheme(
      labelSmall: AppStyle.medium20dark,
      bodyLarge: AppStyle.medium16whit,
      labelLarge: AppStyle.bold16wight,
      headlineMedium: AppStyle.medium14wight,
      headlineLarge: AppStyle.medium24wight,
      bodyMedium: AppStyle.medium24dark,
      bodySmall: AppStyle.medium20whit,
      displayLarge: AppStyle.medium14dark,
    ),
  );
}
