import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    extensions: [MyColors.lightMode],
    shadowColor: const Color(0xFFffffff),
    scaffoldBackgroundColor: Colory.light,
    appBarTheme: const AppBarTheme(
      color: Colory.greenDark,
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black26,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      splashFactory: NoSplash.splashFactory,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2,
          color: Colors.white,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colory.greenLight,
        foregroundColor: Colory.light,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colory.greenLight,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colory.light,
      modalBackgroundColor: Colory.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: Colory.light,
    dialogTheme: DialogTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: const TextTheme(
      // * title used in appbar
      titleLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
      ),
      // * headline used as a title in the body
      headlineMedium: TextStyle(
        fontSize: 14,
        color: Colory.greyLight,
        fontWeight: FontWeight.w500,
      ),
      // * body used in body
      bodyMedium: TextStyle(
        color: Colors.black,
          fontWeight: FontWeight.w500
      ),
      // * label used in appbar & body
      labelLarge: TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        color: Colory.greyLight,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colory.greenLight,
    ),
  );
}
