import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/src/data/auth_repository.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  AuthRepository auth;
  HomePage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "E-Mail des User : ${FirebaseAuth.instance.currentUser!.email}",
            ),
            ElevatedButton(
              onPressed: () async {
                await auth.signOut();
              },
              child: const Text("Ausloggen"),
            ),
          ],
        ),
      ),
    );
  }
}
