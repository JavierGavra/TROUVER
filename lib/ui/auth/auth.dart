import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trouver/ui/auth/login_or_register.dart';
import 'package:trouver/ui/bottom_navigation/bottom_navigation.dart';
import 'package:trouver/ui/bottom_navigation/navigation_rail.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const CustomBottomNavigation();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
