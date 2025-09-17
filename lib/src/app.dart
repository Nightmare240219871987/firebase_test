import 'package:firebase_test/src/data/auth_repository.dart';
import 'package:firebase_test/src/features/home_page/presentation/home_page.dart';
import 'package:firebase_test/src/features/login_page/presentation/login_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class App extends StatelessWidget {
  AuthRepository auth;
  App({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChange(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          //showPerformanceOverlay: true,
          home: snapshot.data == null
              ? LoginPage(auth: auth)
              : HomePage(auth: auth),
        );
      },
    );
  }
}
