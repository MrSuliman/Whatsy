import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    extensions: [MyColors.darkMode],
    shadowColor: const Color(0xFF000000),
    scaffoldBackgroundColor: Colory.dark,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colory.greyDark,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: Color(0xFF202c33),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(
        color: Colory.greyDark,
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colory.greenDark,
      unselectedLabelColor: Colory.greyDark,
      splashFactory: NoSplash.splashFactory,
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2,
          color: Colory.greenLight,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colory.greenDark,
        foregroundColor: Colory.dark,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        foregroundColor: Colory.greenLight,
        shape: const StadiumBorder(),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colory.bgGrey,
      modalBackgroundColor: Colory.bgGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: Colory.bgGrey,
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
        color: Colory.greyDark,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
      ),
      // * headline used as title in body
      headlineMedium: TextStyle(
        fontSize: 14,
        color: Colory.greyDark,
        fontWeight: FontWeight.w500,
      ),
      // * body used in body
      bodyLarge: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      // * label used in appbar
      labelLarge: TextStyle(
        fontSize: 13,
        color: Colory.greyDark,
      ),
      // * labelMedium used in body
      labelMedium: TextStyle(
        fontSize: 13,
        color: Colory.greyDark,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        letterSpacing: 0,
        color: Colory.greyDark,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colory.greenLight,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colory.greyDark,
      tileColor: Colory.dark,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Colory.greyDark),
      trackColor: MaterialStatePropertyAll(Color(0xFF344047)),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colory.greenDark,
      selectionColor: Colory.greenDark,
      selectionHandleColor: Colory.greenLight,
    ),
  );
}
