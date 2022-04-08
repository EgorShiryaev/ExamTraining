import 'package:firebase_auth/firebase_auth.dart';

class UserDao {
  final _auth = FirebaseAuth.instance;

  Stream get user => _auth.userChanges();

  Future<void> updateDisplayName(String newName) async {
    await _auth.currentUser?.updateDisplayName(newName);
  }

  Future<void> updateEmail(String newEmail) async {
    await _auth.currentUser?.updateEmail(newEmail);
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> updatePassword(String newPassword) async {
    await _auth.currentUser?.updatePassword(newPassword);
  }

  Future<void> deleteUser() async {
    await _auth.currentUser?.delete();
  }

  Future<void> reAuth(AuthCredential credential) async {
    await _auth.currentUser?.reauthenticateWithCredential(credential);
  }
}
