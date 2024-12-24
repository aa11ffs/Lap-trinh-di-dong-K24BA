import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference usersCollection = _firestore.collection('users');

  static CollectionReference get tasksCollection =>
      _firestore.collection('tasks');

  static WriteBatch get batch => _firestore.batch();

  static Future<T> runTransaction<T>(
      Future<T> Function(Transaction transaction) updateFunction) {
    return _firestore.runTransaction(updateFunction);
  }
}
