import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/common/svg_assets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onClickedSignIp});
  final Function() onClickedSignIp;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future singUpWithEmail() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            content: Text("Sign Up failed, maybe something went wrong !")),
      );
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                    controller: usernameController,
                    cursorColor: ColorApp.accent1,
                    style: TextStyle(
                        fontSize: 14.sp, color: const Color(0xff94A3B8)),
                    decoration: InputDecoration(
                      hintText: "Username",
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
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: ColorApp.accent1,
                    style: TextStyle(
                        fontSize: 14.sp, color: const Color(0xff94A3B8)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email !'
                            : null,
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
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: ColorApp.accent1,
                    obscureText: true,
                    enableSuggestions: false,
                    style: TextStyle(
                        fontSize: 14.sp, color: const Color(0xff94A3B8)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) =>
                        password != null && password.length < 6
                            ? 'Enter min. 6 characters !'
                            : null,
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
                    onPressed: singUpWithEmail,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.accent1),
                    child: Text(
                      "Sign Up",
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
                    text: "Already have account? ",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIp,
                        text: "Login",
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
      ),
    );
  }
}
