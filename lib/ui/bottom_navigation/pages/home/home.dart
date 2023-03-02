import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_now_playing.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_popular.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_top_rated.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_upcoming.dart';
import 'package:trouver/ui/widget/home/home_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? isPotrait;
  int _pagesInit = 0;
  final List<String> _tabBarName = [
    "Top Rated",
    "Popular",
    "Upcoming",
    "Now Playing"
  ];
  final List<Widget> _tabBarPages = const [
    TabTopRated(),
    TabPopular(),
    TabUpcoming(),
    TabNowPlaying(),
  ];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        isPotrait = orientation == Orientation.portrait ? true : false;
        return Scaffold(
          appBar: AppBar(
            centerTitle: isPotrait,
            elevation: 0,
            toolbarHeight: 65,
            backgroundColor: ColorApp.primary,
            title: Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: Image.asset(
                "assets/images/appbar_logo.png",
                filterQuality: FilterQuality.high,
                width: isPotrait! ? 120.w : 60.w,
                height: isPotrait! ? 15.h : 65.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            actions: [
              IconButton(
                  splashRadius: 22.r,
                  onPressed: () {},
                  icon: Icon(Icons.search, size: isPotrait! ? 20.r : 50.r)),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.spMin),
                HomeSlider(),

                // Category
                SizedBox(
                  height: isPotrait! ? 32.h : 32,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    separatorBuilder: (context, index) => SizedBox(width: 13.w),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _pagesInit = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          padding: EdgeInsets.symmetric(
                              vertical: 7.h, horizontal: 22.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _pagesInit == index
                                  ? ColorApp.accent2
                                  : ColorApp.secondary,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            _tabBarName[index],
                            style: TextStyle(
                              fontWeight: _pagesInit == index
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: 12.spMin,
                              color: _pagesInit == index
                                  ? const Color(0xffF2E5D7)
                                  : const Color(0xffEEEEEE),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _tabBarPages[_pagesInit],
              ],
            ),
          ),
        );
      },
    );
  }
}

Scaffold IsLanscape() {
  return Scaffold(
    body: Center(
      child: Text('landscape'),
    ),
  );
}
