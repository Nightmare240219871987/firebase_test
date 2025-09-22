import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseRepository {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readCollection(
    String nameOfCollection,
  );
  Future<int> getCollectionLength(String nameOfCollection);
  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getSingleDocument(
    String nameOfCollection,
    String nameOfDocument,
  );
}
