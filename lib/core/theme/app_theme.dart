import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';

class AppTheme {
  static ThemeData lightMode = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
        background: AppColors.backgroundColorWhite,
        secondary: AppColors.primaryColor,
        primary: AppColors.primaryColor),
    splashColor: AppColors.primaryColor,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      modalBackgroundColor: Colors.transparent,
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: AppColors.titleTextColor,
        fontSize: AppFontSize.s18,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.roboto(
        color: AppColors.titleTextColor,
        fontSize: AppFontSize.s14,
      ),
      titleMedium: GoogleFonts.roboto(
        color: AppColors.titleTextColor,
        fontSize: AppFontSize.s16,
      ),
    ),

    iconTheme: const IconThemeData(
      color: AppColors.iconColorBlack,
      size: 22,
    ),

    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    primaryColor: AppColors.primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.iconColorBlack,
      unselectedItemColor: AppColors.iconColorBlack,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      elevation: AppElevation.eL4,
      backgroundColor: AppColors.navBarBackgroundColor,
    ),
    //  backgroundColor: Color(0xffF6F9F4),
  );

  static ThemeData darkMode = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.dark(
        background: AppColors.backgroundColorDark,
        secondary: AppColors.primaryColor,
        primary: AppColors.primaryColor),
    splashColor: AppColors.primaryColor,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      modalBackgroundColor: Colors.transparent,
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s18,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.roboto(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s14,
      ),
      titleMedium: GoogleFonts.roboto(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s16,
      ),
    ),

    iconTheme: const IconThemeData(
      color: AppColors.iconColorWhite,
      size: 22,
    ),

    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorDark,
    primaryColor: AppColors.primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.iconColorBlack,
      unselectedItemColor: AppColors.iconColorBlack,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      elevation: AppElevation.eL4,
      backgroundColor: AppColors.navBarBackgroundColor,
    ),
    //  backgroundColor: Color(0xffF6F9F4),
  );
}
