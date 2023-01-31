import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/widget/detail/actor_card.dart';
import 'package:trouver/ui/widget/detail/more_information.dart';
import 'package:trouver/ui/widget/detail/movie_detail_card.dart';
import 'package:trouver/ui/widget/detail/review_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  final double _height = 300;
  bool _lastStatus = true;
  List _list = [
    'Action',
    'Advanture',
    'Animation',
    'Thriler',
    'Horor',
    'Musik'
  ];

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
      body: CustomScrollView(
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
                "Spiderman: No Way Home",
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
                        Image.asset(
                          'assets/images/detail_banner.png',
                          height: 221.h,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
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
                                  child: Image.asset(
                                    'assets/images/detail_cover.png',
                                    height: 120,
                                    width: 95,
                                    fit: BoxFit.cover,
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
                                      Text("Spiderman No Way Home",
                                          style: textTheme.headline3),
                                      SizedBox(height: 2.h),
                                      Text(
                                        "スパイダーマン家に帰る方法がない",
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
                      itemCount: _list.length,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 11.h),
                      itemBuilder: (context, index) {
                        return _genreCard(_list[index]);
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
                      "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
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
                              Text("2019-08-03", style: textTheme.bodyText2),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 159.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Runtime :", style: textTheme.bodyText1),
                              Text("120 Minutes", style: textTheme.bodyText2),
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
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(35),
                          splashColor: ColorApp.secondary,
                          child: Ink(
                            height: 44.h,
                            padding: EdgeInsets.symmetric(horizontal: 35.w),
                            decoration: BoxDecoration(
                                color: ColorApp.accent2,
                                borderRadius: BorderRadius.circular(35)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  size: 22.w,
                                  color: ColorApp.accent1,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  "Trailer",
                                  style: TextStyle(
                                      color: ColorApp.accent1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        _likeDislikeButton(Icons.thumb_up_off_alt_outlined,
                            Icons.thumb_up_alt),
                        SizedBox(width: 15.w),
                        _likeDislikeButton(Icons.thumb_down_off_alt_outlined,
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

                  // Actors
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text("Actors", style: textTheme.headline4),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 226.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _list.length,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 15.h),
                      itemBuilder: (context, index) {
                        return ActorCard(
                          name: "Muhammad Vitto Chorleone",
                          character: "Thanos, Thor, Jokowi, Soeharto",
                          image:
                              "https://themoviedb.org/t/p/w500/4ZwZ66zXZyX26Kf2wfeMt1tQZQf.jpg",
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // additional information
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: MoreInformationWidget(),
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
                    child:
                        Text("If You Like {name}", style: textTheme.headline4),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 211.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _list.length,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 15.h),
                      itemBuilder: (context, index) {
                        return MovieDetailCard(
                          name: "Muhammad Vitto Chorleone",
                          character: "Thanos, Thor, Jokowi, Soeharto",
                          image:
                              "https://themoviedb.org/t/p/w500/kt25dfq7Cc6vEjG8AH46YbhZoPC.jpg",
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Recomendation
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text("Recomendations", style: textTheme.headline4),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 211.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _list.length,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 15.h),
                      itemBuilder: (context, index) {
                        return MovieDetailCard(
                          name: "Muhammad Vitto Chorleone",
                          character: "Thanos, Thor, Jokowi, Soeharto",
                          image:
                              "https://themoviedb.org/t/p/w500/kt25dfq7Cc6vEjG8AH46YbhZoPC.jpg",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
