import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/detail/detail_page.dart';

class MovieHomeCard extends StatelessWidget {
  const MovieHomeCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.release,
    required this.rating,
  });
  final int id;
  final String imageUrl, title, release;
  final double rating;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(5),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DetailPage(id: id)));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FadeInImage.assetNetwork(
              image: "https://image.tmdb.org/t/p/w500$imageUrl",
              width: 95.w,
              height: 130.h,
              fit: BoxFit.cover,
              // placeholderFit: BoxFit.cover,
              placeholder: 'assets/images/loading.gif',
            ),
          ),
          SizedBox(width: 22.w),
          Container(
            constraints: BoxConstraints(maxWidth: 165.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Title :", style: textTheme.bodyText1),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2,
                ),
                SizedBox(height: 5.h),
                Text("Release :", style: textTheme.bodyText1),
                Text(release, style: textTheme.bodyText2),
                SizedBox(height: 6.h),
                Text("Average Rating :", style: textTheme.bodyText1),
                Text("$rating", style: textTheme.bodyText2),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 130.h,
            alignment: Alignment.topCenter,
            child: Icon(Icons.bookmark, size: 24.w, color: ColorApp.accent1),
          ),
        ],
      ),
    );
  }
}
