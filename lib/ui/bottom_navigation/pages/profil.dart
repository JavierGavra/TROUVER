import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/common/public_function.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(height: screenSize.height / 2, color: ColorApp.primary),
          Container(
            margin: EdgeInsets.only(top: 161.h),
            padding: EdgeInsets.only(top: 72.h, bottom: 75),
            width: screenSize.width,
            decoration: BoxDecoration(
              color: ColorApp.accent1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                Text("UserName Kamu", style: textTheme.headline2),
                SizedBox(height: 13.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.2.h, horizontal: 17.w),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: ColorApp.secondary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "User@gmail.com",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorApp.secondary),
                  ),
                ),
                SizedBox(height: 44.h),
                button(context, Icons.account_circle, "Account", () {}),
                SizedBox(height: 18.h),
                button(context, Icons.bookmark, "Watchlist", () {}),
                SizedBox(height: 18.h),
                button(context, Icons.history, "History", () {}),
                SizedBox(height: 18.h),
                button(context, Icons.info, "About", () {}),
                SizedBox(height: 18.h),
                button(context, Icons.logout, "Log Out", () {}),
              ],
            ),
          ),
          Positioned(
            top: 96.h,
            left: (screenSize.width - 130.h) / 2,
            child: Container(
              width: 130.h,
              height: 130.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorApp.accent2,
                shape: BoxShape.circle,
                border: Border.all(color: ColorApp.primary, width: 5.w),
              ),
              child: Text(
                "JG",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget button(
      BuildContext context, IconData icon, String text, Function()? function) {
    final bool isLogOut = text == "Log Out";
    return InkWell(
      onTap: function,
      child: Container(
        height: 50.h,
        width: 270.w,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: isLogOut ? Colors.red : ColorApp.secondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color(0x4D000000), offset: Offset(0, 3), blurRadius: 4),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 25.r,
              color: isLogOut ? Colors.white : ColorApp.accent1,
            ),
            const SizedBox(width: 18),
            Text(
              text,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const Spacer(),
            isLogOut
                ? const SizedBox()
                : Icon(Icons.arrow_forward, size: 25, color: ColorApp.accent1)
          ],
        ),
      ),
    );
  }
}
