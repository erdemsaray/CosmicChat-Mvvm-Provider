import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/firebase_options.dart';
import 'core/services/locator.dart';
import 'core/services/navigator_service.dart';
import 'view_models.dart/sign_in_model.dart';
import 'views/sign_in_page.dart';
import 'views/whatsapp_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUpLocators();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => SignInModel(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;

    if (firebaseUser != null) {
      firstWidget = WhatsappMain();
    } else {
      firstWidget = const SignInPage();
    }

    final ThemeData theme = ThemeData();
    return MaterialApp(
        navigatorKey: getIt<NavigatorService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'WhatApp Clone',
        theme: theme.copyWith(
          backgroundColor: Colors.black,
          colorScheme: theme.colorScheme.copyWith(primary: Color.fromARGB(255, 63, 140, 65), secondary: Colors.green),
        ),
        home: firstWidget);
  }
}
