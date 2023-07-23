import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/model/movie_now_playing_model.dart';
import 'package:trouver/model/movie_top_rated_model.dart';
import 'package:trouver/service/api_service.dart';
import 'package:trouver/ui/widget/home/movie_home_card.dart';
import 'package:trouver/ui/widget/home/movie_home_card_landscape.dart';
import 'package:trouver/ui/widget/home/movie_home_shimmer.dart';

class TabNowPlaying extends StatefulWidget {
  const TabNowPlaying({super.key});

  @override
  State<TabNowPlaying> createState() => _TabNowPlayingState();
}

class _TabNowPlayingState extends State<TabNowPlaying> {
  MovieNowPlayingModel? _movieNowPlayingModel;
  String drdValue = "US";
  final List<DropdownMenuItem<String>> drdItem = const [
    DropdownMenuItem(child: Text("American"), value: "US"),
    DropdownMenuItem(child: Text("Indonesian"), value: "ID"),
  ];

  Future _getData(String region) async =>
      _movieNowPlayingModel = await ApiService().getMovieNowPlaying(region);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(drdValue),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              children: [
                DropdownButton(
                  value: drdValue,
                  isExpanded: true,
                  items: drdItem,
                  dropdownColor: ColorApp.secondary,
                  icon: Icon(Icons.arrow_drop_down, color: ColorApp.accent1),
                  style: TextStyle(
                      color: ColorApp.accent1,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                  underline: Container(height: 1, color: ColorApp.accent2),
                  onChanged: (value) {
                    setState(() {
                      drdValue = value!.toString();
                    });
                  },
                ),
                SizedBox(height: 20.h),
                MediaQuery.of(context).orientation == Orientation.portrait? ListView.separated(
                  itemCount: _movieNowPlayingModel!.results!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 18.h),
                  itemBuilder: (context, index) {
                    final item = _movieNowPlayingModel!.results![index];
                    return MovieHomeCard(
                      id: item.id!.toInt(),
                      imageUrl: item.posterPath.toString(),
                      title: item.title.toString(),
                      release: item.releaseDate.toString(),
                      rating: 9.5,
                    );
                  },
                ):GridView.builder(
                  itemCount: _movieNowPlayingModel!.results!.length,
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
                    final item = _movieNowPlayingModel!.results![index];
                    return MovieHomeCardLandscape(
                      id: item.id!.toInt(),
                      gambar: item.posterPath.toString(),
                      judul: item.title.toString(),
                      penonton: item.releaseDate.toString(),
                      rating: item.voteAverage!.toString(),
                    );
                  },
                ),
              ],
            ),
          );
        }
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
      },
    );
  }
}
