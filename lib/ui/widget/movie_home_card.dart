import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';

class MovieHomeCard extends StatelessWidget {
  const MovieHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/images/kalam_profil.png",
            width: 95.w,
            height: 120.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 22.w),
        Container(
          constraints: BoxConstraints(maxWidth: 165.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title :", style: textTheme.bodyText1),
              Text(
                "Avangers End Game",
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText2,
              ),
              SizedBox(height: 6.h),
              Text("Release :", style: textTheme.bodyText1),
              Text("2019-08-03", style: textTheme.bodyText2),
              SizedBox(height: 6.h),
              Text("Average Rating :", style: textTheme.bodyText1),
              Text("9.5", style: textTheme.bodyText2),
            ],
          ),
        ),
        const Spacer(),
        Container(
          height: 120.h,
          alignment: Alignment.topCenter,
          child: Icon(Icons.bookmark, size: 24.w, color: ColorApp.accent1),
        ),
      ],
    );
  }
}
