import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loczone/core/extinsions/extinsions.dart';
import 'package:loczone/core/utils/app_colors.dart';

class AppThemes {
  static final AppThemes instance = AppThemes();

  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: context.width / context.height >= 0.6 ? 60.h : null,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: context.width / context.height >= 0.6 ? 30.h : 20.h,
        ),
      ),
      // fontFamily: AppStrings.fontName,
      textTheme: TextTheme(),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 1,
        selectedIconTheme: IconThemeData(
          size: 25.h,
          color: AppColors.primaryColor,
        ),
        unselectedIconTheme: IconThemeData(size: 20.h, color: Colors.grey),
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    );
  }
}
