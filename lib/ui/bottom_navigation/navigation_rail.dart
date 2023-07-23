// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trouver/common/app_color.dart';
// import 'package:trouver/ui/bottom_navigation/pages/home/home.dart';
// import 'package:trouver/ui/bottom_navigation/pages/kotak_masuk/kotak_masuk.dart';
// import 'package:trouver/ui/bottom_navigation/pages/profil/profil.dart';
//
// class CustomNavigationRail extends StatefulWidget {
//   const CustomNavigationRail({Key? key}) : super(key: key);
//
//   @override
//   State<CustomNavigationRail> createState() => _CustomNavigationRailState();
// }
//
// class _CustomNavigationRailState extends State<CustomNavigationRail> {
//   int selectedIndex = 0;
//
//   final _pages = const [
//     HomePage(),
//     Center(child: Text("data")),
//     KotakMasukPage(),
//     ProfilPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           NavigationRail(
//             selectedIndex: selectedIndex.toInt(),
//             onDestinationSelected: (index) {
//               setState(() {
//                 selectedIndex = index;
//               });
//             },
//             selectedIconTheme: IconThemeData(
//               color: Colors.white
//             ),
//             backgroundColor: Colors.black12,
//             destinations: const [
//               NavigationRailDestination(
//                   icon: Icon(Icons.home,),
//                   label: Text('Home')
//               ),
//               NavigationRailDestination(
//                   icon: Icon(Icons.tv),
//                   label: Text('Tv')
//               ),
//               NavigationRailDestination(
//                   icon: Icon(Icons.notifications),
//                   label: Text('Notifikasi')
//               ),
//               NavigationRailDestination(
//                   icon: Icon(Icons.account_circle),
//                   label: Text('Account')
//               )
//             ],
//           ),
//           Expanded(child: Container(
//             color: Colors.blue,
//             child: _pages[selectedIndex],
//           ))
//         ],
//       ),
//     );
//   }
// }
