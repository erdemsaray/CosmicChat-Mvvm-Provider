import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'product/services/firebase_options.dart';
import 'product/services/locator.dart';
import 'product/services/navigator_service.dart';
import 'product/view_models.dart/sign_in_model.dart';
import 'product/views/homepage.dart';
import 'product/views/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUpLocators();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
      firstWidget = HomePage();
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
