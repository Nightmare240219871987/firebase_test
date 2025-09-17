import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:firebase_test/src/app.dart';
import 'package:firebase_test/src/data/auth_repository.dart';
import 'package:firebase_test/src/data/firebase_auth_repository.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AuthRepository auth = FirebaseAuthRepository();
  runApp(App(auth: auth));
}
