import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/model/movie_top_rated_model.dart';
import 'package:trouver/service/api_service.dart';
import 'package:trouver/ui/widget/home/movie_home_card.dart';
import 'package:trouver/ui/widget/home/movie_home_card_landscape.dart';
import 'package:trouver/ui/widget/home/movie_home_shimmer.dart';

class TabTopRated extends StatefulWidget {
  const TabTopRated({super.key});

  @override
  State<TabTopRated> createState() => _TabTopRatedState();
}

class _TabTopRatedState extends State<TabTopRated> {
  bool? isPotrait;
  MovieTopRatedModel? _movieTopRatedModel;

  Future _getData() async =>
      _movieTopRatedModel = await ApiService().getMovieTopRated();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        isPotrait = orientation == Orientation.portrait ? true : false;
        return FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return isPotrait!
                  ? ListView.separated(
                      itemCount: _movieTopRatedModel!.results!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: 30.h, horizontal: 20.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 18.h),
                      itemBuilder: (context, index) {
                        final item = _movieTopRatedModel!.results![index];
                        return MovieHomeCard(
                          id: item.id!.toInt(),
                          imageUrl: item.posterPath.toString(),
                          title: item.title.toString(),
                          release: item.releaseDate.toString(),
                          rating: item.voteAverage!.toDouble(),
                        );
                      },
                    )
                  : GridView.builder(
                      itemCount: _movieTopRatedModel!.results!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 27,
                              childAspectRatio: (145 / 147)),
                      itemBuilder: (context, index) {
                        final item = _movieTopRatedModel!.results![index];
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
      },
    );
  }
}
