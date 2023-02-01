import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/detail/detail_page.dart';

class MovieDetailCard extends StatelessWidget {
  const MovieDetailCard({
    super.key,
    required this.id,
    required this.title,
    required this.view,
    required this.image,
  });
  final int id;
  final String title, view, image;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DetailPage(id: id)));
      },
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 211.h,
        width: 120.w,
        child: Stack(
          children: [
            Ink(
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
                  child: CachedNetworkImage(
                    height: 135.h,
                    width: 120.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => FittedBox(
                      fit: BoxFit.none,
                      child: CircularProgressIndicator(color: ColorApp.accent1),
                    ),
                    imageUrl: image,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: 120.w,
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "$view views",
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
      ),
    );
  }
}
