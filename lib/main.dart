import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trouver/common/app_theme_data.dart';
import 'package:trouver/firebase_options.dart';
import 'package:trouver/ui/auth/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:trouver/ui/splash_screen/splash_screen.dart';

import 'common/PushNotificationConfig.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  await PushNotificationConfig().requestPermission();
  await PushNotificationConfig().androidNotificationChanel();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true
  // );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // // foreground Message
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: AppThemeData.getThemeDark(context),
          home: SplashScreen(),
        );
      },
    );
  }
}
