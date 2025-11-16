import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe/firebase_options.dart';
import 'package:myshetribe/screens/splash_screen.dart';
import 'package:myshetribe/screens/verifications/view/welcome_screen.dart';
import 'package:myshetribe/screens/welcome_screen.dart';
import 'package:myshetribe/providers/auth_provider.dart';
import 'package:myshetribe/providers/user_provider.dart';
import 'package:myshetribe/providers/tribe_provider.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/providers/partnership_provider.dart';
import 'package:myshetribe/services/fcm_service.dart';

GlobalKey<NavigatorState>? navigatorKey=GlobalKey<NavigatorState>();

// Background message handler for FCM
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TribeProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => PartnershipProvider()),
      ],
      child: MaterialApp(
        navigatorKey:navigatorKey ,
        debugShowCheckedModeBanner: false,
        title: 'myshetribe',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:SplashScreen()
      ),
    );
  }
}
