import 'package:firebase_auth/firebase_auth.dart';

class UserDao {
  final _user = FirebaseAuth.instance.currentUser;

  User? get user => _user;

  Future<void> updateDisplayName(String newName) async {
    await _user?.updateDisplayName(newName);
  }

  Future<void> updateEmail(String newEmail) async {
    await _user?.updateEmail(newEmail);
  }

  Future<void> sendEmailVerification() async {
    await _user?.sendEmailVerification();
  }

  Future<void> updatePassword(String newPassword) async {
    await _user?.updatePassword(newPassword);
  }

  Future<void> deleteUser() async {
    await _user?.delete();
  }

  Future<void> reAuth(AuthCredential credential) async {
    await user?.reauthenticateWithCredential(credential);
  }
}
