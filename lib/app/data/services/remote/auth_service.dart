import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/providers/firebase_provider.dart';

class AuthService {
  final CollectionReference _usersRef = FirebaseProvider.usersCollection;

  Future<UserModel?> login(String email, String password) async {
    try {
      final querySnapshot =
          await _usersRef.where('email', isEqualTo: email).limit(1).get();
      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      if (userData['password'] != password) {
        return null;
      }
      return UserModel.fromJson(userData);
    } catch (e) {
      print('Error in AuthService.login: $e');
      return null;
    }
  }

  Future<String> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final userDoc = await _usersRef.doc(userId).get();

      final userData = userDoc.data() as Map<String, dynamic>;
      if (userData['password'] != oldPassword) {
        return 'Incorrect password';
      }

      if (oldPassword == newPassword) {
        return 'Same password';
      }

      await _usersRef.doc(userId).update({'password': newPassword});
      return 'Password changed';
    } catch (e) {
      print('Error in AuthService.changePassword: $e');
      return 'Error';
    }
  }
}
