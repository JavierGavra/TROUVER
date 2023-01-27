import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/model/movie_top_rated_model.dart';
import 'package:trouver/service/api_service.dart';
import 'package:trouver/ui/widget/home/movie_home_card.dart';
import 'package:trouver/ui/widget/home/movie_home_shimmer.dart';

class TabLatest extends StatefulWidget {
  const TabLatest({super.key});

  @override
  State<TabLatest> createState() => _TabLatestState();
}

class _TabLatestState extends State<TabLatest> {
  MovieTopRatedModel? _movieTopRatedModel;

  Future _getData() async =>
      _movieTopRatedModel = await ApiService().getMovieTopRated();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: _movieTopRatedModel!.results!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            separatorBuilder: (context, index) => SizedBox(height: 18.h),
            itemBuilder: (context, index) {
              final item = _movieTopRatedModel!.results![index];
              return MovieHomeCard(
                id: item.id!.toInt(),
                imageUrl: item.posterPath.toString(),
                title: item.title.toString(),
                release: item.releaseDate.toString(),
                rating: 9.5,
              );
            },
          );
        } else {
          return ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            separatorBuilder: (context, index) => SizedBox(height: 18.h),
            itemBuilder: (context, index) {
              return const MovieHomeShimmer();
            },
          );
        }
      },
    );
  }
}
