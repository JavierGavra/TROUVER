import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';

class AppThemeData {
  static ThemeData getThemeLight(BuildContext context) {
    return ThemeData(
      primaryColor: ColorApp.primary,
      accentColor: ColorApp.accent2,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorApp.primary,
      iconTheme: IconThemeData(color: ColorApp.primary),
      fontFamily: "Poppins",
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
