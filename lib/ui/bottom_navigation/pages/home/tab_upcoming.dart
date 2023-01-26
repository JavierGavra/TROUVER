import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/model/movie_top_rated_model.dart';
import 'package:trouver/model/movie_upcoming_model.dart';
import 'package:trouver/service/api_service.dart';
import 'package:trouver/ui/widget/movie_home_card.dart';

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
          return ListView.separated(
            itemCount: _movieUpcomingModel!.results!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            separatorBuilder: (context, index) => SizedBox(height: 18.h),
            itemBuilder: (context, index) {
              final item = _movieUpcomingModel!.results![index];
              return MovieHomeCard();
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
