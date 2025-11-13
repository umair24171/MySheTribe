import 'package:flutter/material.dart';
import 'package:myshetribe/screens/splash_screen.dart';
import 'package:myshetribe/screens/verifications/view/welcome_screen.dart';
import 'package:myshetribe/screens/welcome_screen.dart';
GlobalKey<NavigatorState>? navigatorKey=GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:navigatorKey ,
      debugShowCheckedModeBanner: false,
      title: 'myshetribe',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:SplashScreen()
  );
  }
}
