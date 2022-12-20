import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/services/locator.dart';
import 'screens/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatApp Clone',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(primary: Color.fromARGB(255, 63, 140, 65), secondary: Colors.green),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Beklenmeyen bir hata oluştu"),
            );
          } else if (snapshot.hasData) {
            return const SignInPage();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
