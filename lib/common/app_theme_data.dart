import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';

class AppThemeData {
  static ThemeData getThemeDark(BuildContext context) {
    final Color primaryColor = ColorApp.primary;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
      primaryColor: ColorApp.primary,
      primarySwatch: primaryMaterialColor,
      accentColor: ColorApp.accent2,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorApp.primary,
      iconTheme: IconThemeData(color: ColorApp.primary),
      fontFamily: "Poppins",
      // appBarTheme: AppBarTheme(backgroundColor: ColorApp.primary, elevation: 0),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
