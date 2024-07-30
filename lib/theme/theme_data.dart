import 'package:flutter/material.dart';
import 'package:messaging_app/constants/light_theme_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: LightThemeColors.primaryColor,
  scaffoldBackgroundColor: Colors.grey[300],
  colorScheme: ColorScheme.light(
    // logo color
    inverseSurface: Colors.grey.shade800,
    // suffixIcon color
    inversePrimary: Colors.grey.shade700,
    shadow: Colors.grey.shade200,
    onSurface: Colors.black,
    surface: Colors.grey.shade600,

    tertiary: Colors.white,
    tertiaryContainer: Colors.black,

    onTertiary: Colors.black,
    onTertiaryContainer: Colors.white,

    // message field
    onSecondary: Colors.grey.shade800,
    onSecondaryContainer: Colors.grey.shade200,
    onSecondaryFixed: Colors.black,
    onSecondaryFixedVariant: Colors.grey.shade600,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[300],
    elevation: 5,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: 'Chillax-medium',
    ),
    actionsIconTheme: IconThemeData(
      size: 20,
      color: Colors.grey.shade700,
    ),
  ),
  dividerColor: Colors.grey.shade400,
  cardColor: Colors.grey.shade100,
  textTheme: TextTheme(
    labelMedium: const TextStyle(
      color: LightThemeColors.textColor,
      fontSize: 16,
      fontFamily: 'Chillax-semibold',
    ),
    displayMedium: const TextStyle(
      color: LightThemeColors.textColor,
      fontFamily: 'Chillax-medium',
    ),
    displaySmall: TextStyle(
      color: Colors.grey.shade700,
      fontFamily: 'Chillax-medium',
    ),
    titleSmall: TextStyle(
      color: Colors.grey.shade800,
      fontSize: 16,
      fontFamily: 'Chillax-regular',
    ),
    titleMedium: const TextStyle(
      color: Colors.deepPurple,
      fontFamily: 'Chillax-medium',
      fontSize: 18,
    ),
    headlineMedium: const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontFamily: 'Chillax-medium',
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.deepPurple,
  // scaffoldBackgroundColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    // logo color
    inverseSurface: Colors.grey.shade200,
    // suffixIcon color
    inversePrimary: Colors.grey.shade400,
    shadow: Colors.grey.shade700,
    onSurface: Colors.blueGrey.shade300,
    surface: Colors.grey.shade800,

    tertiary: Colors.black,
    tertiaryContainer: Colors.white,

    onTertiary: Colors.white,
    onTertiaryContainer: Colors.grey.shade700,

    // message field
    onSecondary: Colors.grey.shade200,
    onSecondaryContainer: Colors.grey.shade700,
    onSecondaryFixed: Colors.grey.shade200,
    onSecondaryFixedVariant: Colors.grey.shade400,
    

  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    elevation: 5,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'Chillax-medium',
    ),
    actionsIconTheme: IconThemeData(
      size: 20,
      color: Colors.grey.shade400,
    ),
  ),
  dividerColor: Colors.grey.shade700,
  cardColor: Colors.grey.shade800,
  textTheme: TextTheme(
    labelMedium: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Chillax-semibold',
    ),
    displayMedium: const TextStyle(
      color: Colors.white,
      fontFamily: 'Chillax-medium',
    ),
    displaySmall: TextStyle(
      color: Colors.grey.shade400,
      fontFamily: 'Chillax-medium',
    ),
    titleSmall: TextStyle(
      color: Colors.grey.shade200,
      fontSize: 16,
      fontFamily: 'Chillax-regular',
    ),
    titleMedium: const TextStyle(
      color: Colors.deepPurpleAccent,
      fontFamily: 'Chillax-medium',
      fontSize: 18,
    ),
    headlineMedium: const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontFamily: 'Chillax-medium',
    ),
  ),
);
