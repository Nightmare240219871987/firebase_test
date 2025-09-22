import 'package:firebase_test/src/data/database_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository implements DatabaseRepository {
  late FirebaseFirestore db;
  FirebaseRepository() {
    db = FirebaseFirestore.instance;
  }

  @override
  Future<int> getCollectionLength(String nameOfCollection) async {
    QuerySnapshot<Map<String, dynamic>> coll = await db
        .collection(nameOfCollection)
        .get();
    return coll.size;
  }

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getSingleDocument(
    String nameOfCollection,
    String nameOfDocument,
  ) async {
    QuerySnapshot<Map<String, dynamic>> coll = await db
        .collection(nameOfCollection)
        .get();
    return coll.docs
        .toList()
        .where((element) => element["username"] == nameOfDocument)
        .toList()[0];
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readCollection(
    String nameOfCollection,
  ) async {
    QuerySnapshot<Map<String, dynamic>> coll = await db
        .collection(nameOfCollection)
        .get();
    return coll.docs;
  }
}
