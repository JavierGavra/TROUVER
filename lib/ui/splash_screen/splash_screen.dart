import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trouver/common/svg_assets.dart';
import 'package:trouver/ui/auth/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => AuthPage()), (route) => false),
    );

    return Scaffold(
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/splash_screen_background.png',
              height: screenSize.height,
              width: screenSize.width,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            Container(
              height: screenSize.height,
              width: screenSize.width,
              color: Colors.black.withOpacity(0.4),
            ),
            Center(
              child: Image.asset(
                'assets/images/splash_screen_logo.png',
                // filterQuality: FilterQuality.high,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
