import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/model/movie_upcoming_model.dart';
import 'package:trouver/service/api_service.dart';
import 'package:trouver/ui/widget/home/movie_home_card.dart';
import 'package:trouver/ui/widget/home/movie_home_card_landscape.dart';
import 'package:trouver/ui/widget/home/movie_home_shimmer.dart';

class TabUpcoming extends StatefulWidget {
  const TabUpcoming({super.key});

  @override
  State<TabUpcoming> createState() => _TabUpcomingState();
}

class _TabUpcomingState extends State<TabUpcoming> {
  MovieUpcomingModel? _movieUpcomingModel;

  Future _getData() async =>
      _movieUpcomingModel = await ApiService().getMovieUpcoming();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MediaQuery.of(context).orientation == Orientation.portrait? ListView.separated(
            itemCount: _movieUpcomingModel!.results!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            separatorBuilder: (context, index) => SizedBox(height: 18.h),
            itemBuilder: (context, index) {
              final item = _movieUpcomingModel!.results![index];
              return MovieHomeCard(
                id: item.id!.toInt(),
                imageUrl: item.posterPath.toString(),
                title: item.title.toString(),
                release: item.releaseDate.toString(),
                rating: item.voteAverage!.toDouble(),
              );
            },
          ):GridView.builder(
            itemCount: _movieUpcomingModel!.results!.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
                vertical: 30.spMin, horizontal: 20.w),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 24,
                crossAxisSpacing: 27,
                childAspectRatio: (145 / 147)),
            itemBuilder: (context, index) {
              final item = _movieUpcomingModel!.results![index];
              return MovieHomeCardLandscape(
                id: item.id!.toInt(),
                gambar: item.posterPath.toString(),
                judul: item.title.toString(),
                penonton: item.releaseDate.toString(),
                rating: item.voteAverage!.toString(),
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
