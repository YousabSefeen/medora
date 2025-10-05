import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppLightTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.blue,
    unselectedWidgetColor: Colors.grey,
    scaffoldBackgroundColor: Colors.white,
    secondaryHeaderColor: const Color(0xffe85d04),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.softBlue, size: 25.sp),
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.darkBlue,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.softBlue, size: 22.sp),

    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.shade200,
      selectionHandleColor: Colors.blue,
    ),

    scrollbarTheme: ScrollbarThemeData(
      // Margin on both sides (right/left)
      crossAxisMargin: 5,

      interactive: true,
      trackVisibility: const WidgetStatePropertyAll(true),

      thumbColor: WidgetStateProperty.all(AppColors.softBlue),

      trackColor: WidgetStateProperty.all(Colors.black26),
      trackBorderColor: WidgetStateProperty.all(Colors.black),
      radius: const Radius.circular(8),
      thickness: WidgetStateProperty.all(5),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(180),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xff9BBEC8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      elevation: 8,
      shadowColor: Colors.blue.shade300,
      textStyle: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
          color: Colors.black,
          letterSpacing: 1.2,
        ),
      ),
      position: PopupMenuPosition.under,
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: GoogleFonts.caladea(
        textStyle: TextStyle(
          fontSize: 18.sp,
          color: Colors.blue,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 12.sp,
        color: Colors.black54,
        height: 1.5,
        fontWeight: FontWeight.w500,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(1),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        backgroundColor: const WidgetStatePropertyAll(AppColors.darkBlue),
        foregroundColor: const WidgetStatePropertyAll(AppColors.white),
        overlayColor: const WidgetStatePropertyAll(AppColors.grey),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    ),
    /*
     shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black26, width: 1.7),
      )),
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
      foregroundColor: const WidgetStatePropertyAll(Colors.black),
      overlayColor: const WidgetStatePropertyAll(Colors.black12),
     */
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 5)),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              // color: Takes the text color from foregroundColor,
            ),
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        overlayColor: const WidgetStatePropertyAll(Color(0xff427D9D)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xff164863),
      elevation: 8,
      labelStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: Colors.white,
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shadowColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.customLightBlue,
      thickness: 2,
    ),
    checkboxTheme: CheckboxThemeData(),
  );
}
