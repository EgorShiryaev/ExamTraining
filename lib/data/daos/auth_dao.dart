import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_status.dart';

class AuthDao {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  final _technicalErrorText = 'Техническая ошибка.\nПовторите попытку позже';

  Future<AuthStatus> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthStatus(
        message:
            'Пользователь ${credential.additionalUserInfo?.username} успешно создан',
      );
    } on FirebaseAuthException catch (e) {
      late final message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Данный email недействителен';
          break;
        case 'weak-password':
          message = 'Данный пароль слишком слабый';
          break;
        case 'email-already-in-use':
          message = 'Данный email уже используется';
          break;
        case 'operation-not-allowed':
          message =
              'Техническая ошибка.\nСвяжитесь с нами по email:  exam.training.app@gmail.com';
          break;
        default:
          message =_technicalErrorText;
          break;
      }
      return AuthStatus(
        success: false,
        message: message,
      );
    } catch (e) {
      return AuthStatus(
        success: false,
        message: _technicalErrorText,
      );
    }
  }

  Future<AuthStatus> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthStatus(
        message:
            'Пользователь ${credential.additionalUserInfo?.username} успешно авторизован',
      );
    } on FirebaseAuthException catch (e) {
      late final message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Данный email недействителен';
          break;
        case 'user-disabled':
          message = 'Пользователь удалён';
          break;
        case 'user-not-found':
          message = 'Пользователь не найден';
          break;
        case 'wrong-password':
          message = 'Неправильный пароль';
          break;
        default:
          message = _technicalErrorText;
          break;
      }
      return AuthStatus(
        success: false,
        message: message,
      );
    } catch (e) {
      return AuthStatus(
        success: false,
        message: _technicalErrorText,
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
