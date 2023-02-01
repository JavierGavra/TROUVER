import 'package:flutter/material.dart';
import 'package:trouver/ui/auth/login.dart';
import 'package:trouver/ui/auth/register.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignUp: toggle)
      : RegisterPage(onClickedSignIp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
