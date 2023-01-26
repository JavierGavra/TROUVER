import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_latest.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_popular.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_top_rated.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/tab_upcoming.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pagesInit = 0;
  final List<String> _tabBarName = [
    "Top Rated",
    "Popular",
    "Upcoming",
    "Latest"
  ];
  final List<Widget> _tabBarPages = const [
    TabTopRated(),
    TabPopular(),
    TabUpcoming(),
    TabLatest(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("test")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Category
              SizedBox(
                height: 32.h,
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
                            fontSize: 12.sp,
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
      ),
    );
  }
}
