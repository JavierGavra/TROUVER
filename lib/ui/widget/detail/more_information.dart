import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:trouver/common/app_color.dart';

class MoreInformationWidget extends StatelessWidget {
  const MoreInformationWidget({super.key});

  static Color color = ColorApp.accent1;
  static TextStyle contentStyle = TextStyle(
    color: const Color(0xffE1E1E1),
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.13)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.15),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("More Information", style: textTheme.headline4),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status", style: textTheme.bodyText1),
                        Text("Released", style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Tagline", style: textTheme.bodyText1),
                        Text(
                            "A young man torn between loyalty and justice confronts the truth of his father figure that may destroy them both.",
                            style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Production Companies",
                            style: textTheme.bodyText1),
                        Text("Universal Pictures, Dreamworks Animation",
                            style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Production Countries",
                            style: textTheme.bodyText1),
                        Text("Indonesia, Spanyol, Belanda, Norwegia",
                            style: contentStyle),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Adult", style: textTheme.bodyText1),
                        Text("No", style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Language", style: textTheme.bodyText1),
                        Text("Indonesia", style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Spoken Language", style: textTheme.bodyText1),
                        Text("Indonesia, English, Spanish",
                            style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Budget", style: textTheme.bodyText1),
                        Text("\$ 90000000", style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Revenue", style: textTheme.bodyText1),
                        Text("\$ 90000000", style: contentStyle),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
