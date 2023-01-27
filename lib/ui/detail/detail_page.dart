import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/detail/tab_about_movie.dart';
import 'package:trouver/ui/detail/tab_reviews.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  List _list = [
    'Action',
    'Advanture',
    'Animation',
    'Thriler',
    'Horor',
    'Musik'
  ];
  TabController? _tabController;
  ScrollController? _scrollController;
  bool fixedScroll = false;

  _scrollListener() {
    if (fixedScroll) {
      _scrollController!.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController!.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController!.index == 2;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_smoothScrollToTop);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              // toolbarHeight: 314.h,
              expandedHeight: 314.h,
              backgroundColor: ColorApp.primary,
              // title: Text("jdasjdk"),
              pinned: true,
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
                                    width:
                                        MediaQuery.of(context).size.width - 170,
                                    padding: EdgeInsets.only(bottom: 10),
                                    // color: Colors.amberAccent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Spiderman No Way Home",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "スパイダーマン家に帰る方法がない",
                                          style: TextStyle(
                                            color: Color(0xffE1E1E1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
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

                    // Genres view
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
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 33,
                // width: 200,
                child: TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 7),
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0xffA8A8A8),
                  indicatorColor: Color(0xffFA6218),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      text: 'About Movie',
                    ),
                    Tab(
                      text: 'Reviews',
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            TabAbout(),
            TabReviews(),
          ],
        ),
      ),
    );
  }

  Widget _genreCard(String text) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 20.w),
      decoration: BoxDecoration(
          color: ColorApp.secondary, borderRadius: BorderRadius.circular(16)),
      child: Text(text, style: TextStyle(fontSize: 12.sp)),
    );
  }
}
