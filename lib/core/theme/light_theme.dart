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
    iconTheme: const IconThemeData(
      color: Colory.greyLight,
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
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        foregroundColor: Colory.greenDark,
        shape: const StadiumBorder(),
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
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      // * headline used as a title in the body
      headlineMedium: TextStyle(
        fontSize: 14,
        color: Colory.greyLight,
        fontWeight: FontWeight.w500,
      ),
      // * body used in body
      bodyLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      // * labelLarge used in appbar
      labelLarge: TextStyle(
        fontSize: 13,
        color: Colors.white,
      ),
      // * labelMedium used in body
      labelMedium: TextStyle(
        fontSize: 13,
        color: Colory.greyLight,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        letterSpacing: 0,
        color: Colory.greyLight,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colory.greenLight,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colory.greyDark,
      tileColor: Colory.light,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Color(0xFF83939c)),
      trackColor: MaterialStatePropertyAll(Color(0xFFDADFE2)),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colory.greenLight,
      selectionColor: Colory.greenLight.withOpacity(0.35),
      selectionHandleColor: Colory.greenLight,
    ),
  );
}
