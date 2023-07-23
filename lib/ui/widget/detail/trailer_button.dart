import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/common/public_function.dart';

class TrailerButton extends StatelessWidget {
  const TrailerButton({super.key, required this.link});
  final String link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PublicFunction.launchLink(link);
      },
      borderRadius: BorderRadius.circular(35),
      splashColor: ColorApp.secondary,
      child: Ink(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        decoration: BoxDecoration(
            color: ColorApp.accent2, borderRadius: BorderRadius.circular(35)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              size: 22.w,
              color: ColorApp.accent1,
            ),
            SizedBox(width: 4.w),
            Text(
              "Trailer",
              style: TextStyle(
                  color: ColorApp.accent1,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp),
            )
          ],
        ),
      ),
    );
  }
}
