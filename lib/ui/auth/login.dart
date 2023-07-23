import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/common/svg_assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onClickedSignUp});
  final VoidCallback onClickedSignUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future singInWithEmail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            content: Text("Log In failed, maybe something went wrong !")),
      );
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return OrientationBuilder(
      builder: (context, orientation) => orientation == Orientation.portrait ?
      Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const SizedBox(height: 161),
                SvgPicture.asset(
                  loginImg,
                  width: 333.93.w,
                  height: 350.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 40.h,
                  width: 298.w,
                  child: TextField(
                    controller: emailController,
                    cursorColor: ColorApp.accent1,
                    style: TextStyle(
                        fontSize: 14.sp, color: const Color(0xff94A3B8)),
                    decoration: InputDecoration(
                      hintText: "Email",
                      contentPadding: EdgeInsets.symmetric(vertical: 10.w),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14.sp,
                        color: const Color(0xff94A3B8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40.h,
                  width: 298.w,
                  child: TextField(
                    controller: passwordController,
                    cursorColor: ColorApp.accent1,
                    obscureText: true,
                    enableSuggestions: false,
                    style: TextStyle(
                        fontSize: 14.sp, color: const Color(0xff94A3B8)),
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 10.w),
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Roboto",
                        color: const Color(0xff94A3B8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 40.h,
                  width: 298.w,
                  child: ElevatedButton(
                    onPressed: singInWithEmail,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.accent1),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: ColorApp.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 42.h),
                const Text(
                  "Or continue with",
                  style:
                  TextStyle(color: Color(0xff9CA6C1), fontFamily: "Roboto"),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 141.w,
                      height: 40.h,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(width: 1.w, color: ColorApp.accent1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(iconGoogle,
                                height: 18.h, width: 18.w),
                            SizedBox(width: 8.w),
                            const Text("Google",
                                style: TextStyle(color: Color(0xff9CA6C1)))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    SizedBox(
                      width: 141.w,
                      height: 40.h,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: BorderSide(width: 1.w, color: ColorApp.accent1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.facebook, size: 18.r),
                            SizedBox(width: 8.w),
                            Text("Facebook",
                                style: TextStyle(color: Color(0xff9CA6C1)))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontFamily: "Roboto", color: Color(0xFF9CA6C1)),
                    text: "Don't have account? ",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: "Create now",
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ) :
      Scaffold(
        body: Container(
          height: double.maxFinite,
          color: ColorApp.primary,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  loginImg,
                  width: 140.w,
                  height: 140.w,
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 200.w,
                      child: TextField(
                        controller: emailController,
                        cursorColor: ColorApp.accent1,
                        style: TextStyle(
                            fontSize: 8.sp, color: const Color(0xff94A3B8)),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 8.sp,
                            color: const Color(0xff94A3B8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 200.w,
                      child: TextField(
                        controller: passwordController,
                        cursorColor: ColorApp.accent1,
                        obscureText: true,
                        enableSuggestions: false,
                        style: TextStyle(
                            fontSize: 8.sp, color: const Color(0xff94A3B8)),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: 8.sp,
                            fontFamily: "Roboto",
                            color: const Color(0xff94A3B8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      height: 100.h,
                      width: 200.w,
                      child: ElevatedButton(
                        onPressed: singInWithEmail,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.accent1),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: ColorApp.primary,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const Text(
                      "Or continue with",
                      style:
                      TextStyle(color: Color(0xff9CA6C1), fontFamily: "Roboto", fontSize: 14),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80.h,
                          width: 95.w,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(width: 1.w, color: ColorApp.accent1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(iconGoogle,
                                    height: 18.h, width: 18.w),
                                SizedBox(width: 8.w),
                                const Text("Google",
                                    style: TextStyle(color: Color(0xff9CA6C1)))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 95.w,
                          height: 80.h,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: BorderSide(width: 1.w, color: ColorApp.accent1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.facebook, size: 18.r),
                                SizedBox(width: 8.w),
                                Text("Facebook",
                                    style: TextStyle(color: Color(0xff9CA6C1)))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontFamily: "Roboto", color: Color(0xFF9CA6C1)),
                        text: "Don't have account? ",
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignUp,
                            text: "Create now",
                            style: const TextStyle(
                                fontFamily: "Roboto",
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
