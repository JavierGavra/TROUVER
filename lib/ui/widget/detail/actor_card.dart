import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({
    super.key,
    required this.name,
    required this.character,
    required this.image,
  });
  final String name, character, image;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 226.h,
      width: 120.w,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorApp.secondary,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  height: 135.h,
                  width: 120.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                width: 120.w,
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: textTheme.bodyText1),
                    SizedBox(height: 1.h),
                    Text(
                      character,
                      style: TextStyle(
                          color: const Color(0xffE1E1E1), fontSize: 10.sp),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
