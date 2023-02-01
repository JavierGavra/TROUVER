import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/model/movie_cast_model.dart';
import 'package:trouver/model/movie_detail_model.dart';
import 'package:trouver/model/movie_recomendation_model.dart';
import 'package:trouver/model/movie_similiar_model.dart';
import 'package:trouver/model/movie_video_model.dart';
import 'package:trouver/service/api_service.dart';
import 'package:trouver/ui/widget/detail/actor_card.dart';
import 'package:trouver/ui/widget/detail/more_information.dart';
import 'package:trouver/ui/widget/detail/movie_detail_card.dart';
import 'package:trouver/ui/widget/detail/review_button.dart';
import 'package:trouver/ui/widget/detail/trailer_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  MovieDetailModel? _movieDetailModel;
  MovieCastModel? _movieCastModel;
  MovieSimiliarModel? _movieSimiliarModel;
  MovieRecomendationModel? _movieRecomendationModel;
  MovieVideoModel? _movieVideoModel;
  ScrollController? _scrollController;
  final double _height = 300;
  bool _lastStatus = true;

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (_height - kToolbarHeight);
  }

  void _scrollListener() {
    if (_isShrink != _lastStatus) {
      setState(() {
        _lastStatus = _isShrink;
      });
    }
  }

  Future _getData() async {
    _movieDetailModel = await ApiService().getMovieDetail(widget.id.toString());
    _movieSimiliarModel =
        await ApiService().getMovieSimiliar(widget.id.toString());
    _movieCastModel =
        await ApiService().getMovieCast(context, widget.id.toString());
    _movieRecomendationModel =
        await ApiService().getMovieRecomendation(widget.id.toString());
    _movieVideoModel = await ApiService().getMovieVideo(widget.id.toString());
    return _movieDetailModel;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController!.removeListener(_scrollListener);
    _scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  // automaticallyImplyLeading: false,
                  expandedHeight: _height,
                  backgroundColor: ColorApp.primary,
                  pinned: true,
                  title: AnimatedCrossFade(
                    crossFadeState: _isShrink
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 260),
                    firstChild: const Text(""),
                    secondChild: Text(
                      _movieDetailModel!.title.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headline3,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Column(
                      children: [
                        SizedBox(
                          height: 270,
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              CachedNetworkImage(
                                width: MediaQuery.of(context).size.width,
                                height: 221.h,
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://image.tmdb.org/t/p/w500${_movieDetailModel!.backdropPath}",
                              ),
                              Container(
                                height: 221.h,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                      Color.fromARGB(0, 46, 53, 58),
                                      Color.fromARGB(20, 46, 53, 58),
                                      Color(0xff242A32),
                                    ])),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 320.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          width: 95.2,
                                          height: 120.h,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w500${_movieDetailModel!.posterPath}",
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Container(
                                        width: 210.w,
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _movieDetailModel!.title
                                                  .toString(),
                                              style: textTheme.headline3,
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              _movieDetailModel!.originalTitle
                                                  .toString(),
                                              style: TextStyle(
                                                color: const Color(0xffE1E1E1),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 25.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _movieDetailModel!.genres!.length,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 11.h),
                            itemBuilder: (context, index) {
                              final item = _movieDetailModel!.genres![index];
                              return _genreCard(item.name.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            _movieDetailModel!.overview.toString(),
                            style: textTheme.bodyText2,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 159.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Release Date :",
                                        style: textTheme.bodyText1),
                                    Text(
                                      _movieDetailModel!.releaseDate.toString(),
                                      style: textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 159.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Runtime :",
                                        style: textTheme.bodyText1),
                                    Text(
                                        "${_movieDetailModel!.runtime.toString()} Minutes",
                                        style: textTheme.bodyText2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              TrailerButton(
                                  link:
                                      "https://www.youtube.com/watch?v=${_movieVideoModel!.results![_movieVideoModel!.results!.length - 1].key}"),
                              const Spacer(),
                              _likeDislikeButton(
                                  Icons.thumb_up_off_alt_outlined,
                                  Icons.thumb_up_alt),
                              SizedBox(width: 15.w),
                              _likeDislikeButton(
                                  Icons.thumb_down_off_alt_outlined,
                                  Icons.thumb_down_alt),
                              SizedBox(width: 15.w),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(35),
                                splashColor: ColorApp.accent2,
                                child: Ink(
                                  // padding: EdgeInsets.all(10.r),
                                  height: 44.h,
                                  width: 44.w,
                                  decoration: BoxDecoration(
                                    color: ColorApp.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.bookmark_outline,
                                    size: 18.r,
                                    color: ColorApp.accent1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // Cast
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text("Cast (only 10)",
                              style: textTheme.headline4),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 226.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 15.h),
                            itemBuilder: (context, index) {
                              final item = _movieCastModel!.cast![index];
                              if (item.profilePath == null) {
                                return ActorCard(
                                  name: item.name!,
                                  character: item.character!,
                                  image:
                                      "https://media.istockphoto.com/id/518552551/photo/male-silhouette-profile-picture-with-question-mark.jpg?s=612x612&w=0&k=20&c=vCJR4RK29efe_TCPtPdhArezQvp1lcyOMAJ80I8hNOA=",
                                );
                              } else {
                                return ActorCard(
                                  name: item.name!,
                                  character: item.character!,
                                  image:
                                      "https://themoviedb.org/t/p/w500${item.profilePath}",
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // additional information
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: MoreInformationWidget(
                            status: _movieDetailModel!.status!,
                            tagline: _movieDetailModel!.tagline!,
                            pCompanies: _movieDetailModel!.productionCompanies!,
                            pCountries: _movieDetailModel!.productionCountries!,
                            adult: _movieDetailModel!.adult,
                            language: _movieDetailModel!.originalLanguage!,
                            sLanguage: _movieDetailModel!.spokenLanguages!,
                            budget: _movieDetailModel!.budget!,
                            revenue: _movieDetailModel!.revenue!,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ReviewButton(),
                        ),

                        // Separator
                        SizedBox(height: 30.h),
                        Container(color: ColorApp.accent1, height: 2.h),
                        SizedBox(height: 20.h),

                        // Similiar Movie
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text("Maybe You Like This Movie To",
                              style: textTheme.headline4),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 211.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _movieSimiliarModel!.results!.length,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 15.h),
                            itemBuilder: (context, index) {
                              final item = _movieSimiliarModel!.results![index];
                              return MovieDetailCard(
                                id: item.id!,
                                title: item.title!,
                                view: item.popularity!.toString(),
                                image:
                                    "https://themoviedb.org/t/p/w500${item.posterPath}",
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Recomendation
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text("Recomendations",
                              style: textTheme.headline4),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 211.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                _movieRecomendationModel!.results!.length,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 15.h),
                            itemBuilder: (context, index) {
                              final item =
                                  _movieRecomendationModel!.results![index];
                              return MovieDetailCard(
                                id: item.id!,
                                title: item.title!,
                                view: item.popularity!.toString(),
                                image:
                                    "https://themoviedb.org/t/p/w500${item.posterPath}",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(color: ColorApp.accent1));
          }
        },
      ),
    );
  }

  Widget _genreCard(String text) {
    return Container(
      height: 24.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 20.w),
      decoration: BoxDecoration(
          color: ColorApp.secondary, borderRadius: BorderRadius.circular(16)),
      child: Text(text, style: TextStyle(fontSize: 12.sp)),
    );
  }

  Widget _likeDislikeButton(IconData unClick, IconData click) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(35),
      splashColor: ColorApp.accent2,
      child: Ink(
        // padding: EdgeInsets.all(10.r),
        height: 44.h,
        width: 44.w,
        decoration: BoxDecoration(
          color: ColorApp.secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          unClick,
          size: 18.r,
          color: ColorApp.accent1,
        ),
      ),
    );
  }
}
