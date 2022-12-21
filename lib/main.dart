import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/services/locator.dart';
import 'core/services/navigator_service.dart';
import 'firebase_options.dart';
import 'screens/sign_in_page.dart';
import 'whatsapp_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUpLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;

    if (firebaseUser != null) {
      firstWidget = const WhatsappMain();
    } else {
      firstWidget = const SignInPage();
    }

    final ThemeData theme = ThemeData();
    return MaterialApp(
        navigatorKey: getIt<NavigatorService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'WhatApp Clone',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(primary: Color.fromARGB(255, 63, 140, 65), secondary: Colors.green),
        ),
        home: firstWidget);
  }
}
