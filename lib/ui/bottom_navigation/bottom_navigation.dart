import 'package:flutter/material.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/ui/bottom_navigation/pages/home/home.dart';
import 'package:trouver/ui/bottom_navigation/pages/kotak_masuk/kotak_masuk.dart';
import 'package:trouver/ui/bottom_navigation/pages/profil/profil.dart';
import 'package:trouver/ui/widget/navbar_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key, required this.orientation});
  final orientation;

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  bool isPotrait = true;
  int _pagesInit = 0;
  double _tabPositionLeft = 11.w;

  @override
  void initState() {
    super.initState();
    isPotrait = widget.orientation == Orientation.portrait ? true : false;
    onChangedTab(_pagesInit);
  }

  void onChangedTab(int index) {
    setState(() {
      _pagesInit = index;
    });
    if (_pagesInit == 1) {
      setState(() {
        _tabPositionLeft = 97.w;
      });
    } else if (_pagesInit == 2) {
      setState(() {
        _tabPositionLeft = 183.w;
      });
    } else if (_pagesInit == 3) {
      setState(() {
        _tabPositionLeft = 269.w;
      });
    } else {
      setState(() {
        _tabPositionLeft = 11.w;
      });
    }
  }

  final _pages = const [
    HomePage(),
    Center(child: Text("data")),
    KotakMasukPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      _pagesInit = _pagesInit;
    });
    return Scaffold(
        body: _pages[_pagesInit],
        bottomNavigationBar: OrientationBuilder(
          builder: (context, orientation) => orientation == Orientation.portrait
              ? BottomAppBar(
                  // elevation: 0,
                  color: ColorApp.secondary,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                        left: _tabPositionLeft,
                        child: Container(
                          height: 40.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorApp.accent2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 11.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NavbarItem(
                                icon: Icons.home_outlined,
                                iconSelcted: Icons.home,
                                indexItem: 0,
                                index: _pagesInit,
                                message: "Home",
                                onChangedTab: onChangedTab),
                            NavbarItem(
                                icon: Icons.tv_outlined,
                                iconSelcted: Icons.tv,
                                indexItem: 1,
                                index: _pagesInit,
                                message: "TV",
                                onChangedTab: onChangedTab),
                            NavbarItem(
                                icon: Icons.mail_outline,
                                iconSelcted: Icons.mail,
                                indexItem: 2,
                                index: _pagesInit,
                                message: "Inbox",
                                onChangedTab: onChangedTab),
                            NavbarItem(
                                icon: Icons.person_outline,
                                iconSelcted: Icons.person,
                                indexItem: 3,
                                index: _pagesInit,
                                message: "Profile",
                                onChangedTab: onChangedTab),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _pagesInit.toInt(),
                      onDestinationSelected: (index) {
                        setState(() {
                          _pagesInit = index;
                        });
                      },
                      selectedIconTheme: IconThemeData(color: Colors.white),
                      backgroundColor: Colors.black12,
                      destinations: const [
                        NavigationRailDestination(
                            icon: Icon(
                              Icons.home,
                            ),
                            label: Text('Home')),
                        NavigationRailDestination(
                            icon: Icon(Icons.tv), label: Text('Tv')),
                        NavigationRailDestination(
                            icon: Icon(Icons.notifications),
                            label: Text('Notifikasi')),
                        NavigationRailDestination(
                            icon: Icon(Icons.account_circle),
                            label: Text('Account'))
                      ],
                    ),
                    Expanded(
                        child: Container(
                      child: _pages[_pagesInit],
                    ))
                  ],
                ),
        ));
  }
}
