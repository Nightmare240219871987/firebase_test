import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/src/data/auth_repository.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  AuthRepository auth;

  LoginPage({super.key, required this.auth});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();

  final TextEditingController _passwordCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Form(
                key: _formKey,
                child: Column(
                  spacing: 8.0,
                  children: [
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "E-Mail",
                        hintText: "Geben sie eine E-Mail Adresse ein.",
                      ),
                      onChanged: (value) => _formKey.currentState!.validate(),
                      validator: (value) {
                        RegExp re = RegExp(r"(.*?@.*?\.de)");
                        if (value == null || value.isEmpty) {
                          return "Die E-Mail darf nicht leer sein.";
                        }
                        if (!re.hasMatch(value)) {
                          return "Es muss eine gültige E-Mail eingegeben werden.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Passwort",
                        hintText: "Geben sie ihr passwort ein.",
                      ),
                      onChanged: (value) => _formKey.currentState!.validate(),
                      validator: (value) {
                        RegExp reExtraSigns = RegExp(r'[@!?.#%&§="]');
                        RegExp reLowerCase = RegExp(r"[a-z]");
                        RegExp reUpperCase = RegExp(r"[A-Z]");
                        RegExp reNumber = RegExp(r"\d");
                        if (value == null || value.isEmpty) {
                          return "Das Passwort darf nicht leer sein.";
                        }
                        if (value.length < 8) {
                          return "Das Passwort muss mindestens 8 Zeichen enthalten.";
                        }
                        if (!reExtraSigns.hasMatch(value)) {
                          return "Das Passwort muss Sonderzeichen enthalten.";
                        }
                        if (!reNumber.hasMatch(value)) {
                          return "Das Passwort muss Zahlen enthalten.";
                        }
                        if (!reLowerCase.hasMatch(value)) {
                          return "Das Passwort muss kleine Buchstaben enthalten.";
                        }
                        if (!reUpperCase.hasMatch(value)) {
                          return "Das Passwort muss große Buchstaben enthalten";
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.auth.signInWithEmailAndPassword(
                              _emailCtrl.text,
                              _passwordCtrl.text,
                            );
                          },
                          child: const Text("Einloggen"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signInAnonymously();
                          },
                          child: const Text("Login als Anonym"),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: null,
                      child: const Text("Registrieren"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
