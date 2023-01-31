import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/model/movie_popular_model.dart';
import 'package:trouver/service/api_service.dart';
import 'package:trouver/ui/detail/detail_page.dart';
import 'package:trouver/ui/widget/shimmer_widget.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final CarouselController _controller = CarouselController();
  MoviePopularModel? _moviePopularModel;
  int _current = 0;
  List imgList = [1, 2, 3, 4];

  Future _getData() async =>
      _moviePopularModel = await ApiService().getMoviePopular();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: 4,
                carouselController: _controller,
                options: CarouselOptions(
                  height: 155.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  final item = _moviePopularModel!.results![index];
                  return _sliderCard(item);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: _current == entry.key ? 20.w : 7.w,
                      height: 7.h,
                      margin: EdgeInsets.only(
                          top: 18.h, bottom: 17.h, left: 5.w, right: 5.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: 4,
                carouselController: _controller,
                options: CarouselOptions(
                  height: 155.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return ShimmerWidget(
                    height: 155.h,
                    width: 328.w,
                    radius: 12.r,
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 18.h, bottom: 17.h, left: 5.w, right: 5.w),
                child: ShimmerWidget(height: 7.h, width: 60.w, radius: 16.r),
              )
            ],
          );
        }
      },
    );
  }

  Widget _sliderCard(var item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => DetailPage(id: item.id)));
      },
      child: SizedBox(
        height: 155.h,
        width: 328.w,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: FadeInImage.assetNetwork(
                  image:
                      "https://image.tmdb.org/t/p/w500${item.backdropPath.toString()}",
                  placeholder: "assets/images/loading.gif",
                  fit: BoxFit.cover,
                  placeholderFit: BoxFit.contain,
                  width: 328.w,
                )),
            Container(
              height: 155.h,
              padding: EdgeInsets.only(bottom: 12.w, left: 12.w),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(80, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    item.releaseDate,
                    style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
