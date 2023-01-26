import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/widget/shimmer_widget.dart';

class MovieHomeShimmer extends StatelessWidget {
  const MovieHomeShimmer({super.key});
  SizedBox _titleSeparator() => const SizedBox(height: 2);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerWidget(width: 95.w, height: 120.h, radius: 16),
        SizedBox(width: 22.w),
        Container(
          constraints: BoxConstraints(maxWidth: 165.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(height: 12, width: 60),
              _titleSeparator(),
              ShimmerWidget(height: 12, width: 130),
              SizedBox(height: 6.h),
              ShimmerWidget(height: 12, width: 60),
              _titleSeparator(),
              ShimmerWidget(height: 12, width: 130),
              SizedBox(height: 6.h),
              ShimmerWidget(height: 12, width: 60),
              _titleSeparator(),
              ShimmerWidget(height: 12, width: 130),
            ],
          ),
        ),
        const Spacer(),
        Container(
          height: 120.h,
          alignment: Alignment.topCenter,
          child: ShimmerWidget(height: 24, width: 24),
        ),
      ],
    );
  }
}
