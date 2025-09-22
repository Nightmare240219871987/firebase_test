import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/src/data/auth_repository.dart';
import 'package:firebase_test/src/data/database_repository.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  AuthRepository auth;
  DatabaseRepository db;
  HomePage({super.key, required this.auth, required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "E-Mail des User : ${FirebaseAuth.instance.currentUser!.email}",
            ),
            FutureBuilder(
              future: db.getCollectionLength("users"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return Text(
                    "Anzahl der Elemente : ${snapshot.data!.toString()}",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  );
                }
                return Text("Es wurde noch keine Aktion ausgeführt.");
              },
            ),
            FutureBuilder(
              future: db.readCollection("users"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(snapshot.data![index]["username"]),
                          subtitle: Text(
                            snapshot.data![index]["creationTime"].toString(),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Text("Es wurde keine Aktion ausgeführt.");
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await auth.signOut();
                  },
                  child: const Text("Ausloggen"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    QueryDocumentSnapshot<Map<String, dynamic>> doc = await db
                        .getSingleDocument("users", "Nightmare22");
                    print(
                      "${doc["username"]} : wurde ${doc["creationTime"]} erstellt.",
                    );
                  },
                  child: const Text("Get Second Element"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
