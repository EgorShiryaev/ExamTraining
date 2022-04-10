import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_status.dart';

const technicalErrorText = 'Техническая ошибка.\nПовторите попытку позже';
const technicalStatus = 'technicalStatus';
const requiresRecentLogin = 'requires-recent-login';

class AuthDao {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  Stream get userChanges => _auth.userChanges();

  User get user => _auth.currentUser!;

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
      late final String message;
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
          message = technicalErrorText;
          break;
      }
      return AuthStatus(success: false, message: message);
    } catch (e) {
      return AuthStatus(
        success: false,
        message: technicalErrorText,
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
      late final String message;
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
          message = technicalErrorText;
          break;
      }
      return AuthStatus(
        success: false,
        message: message,
      );
    } catch (e) {
      return AuthStatus(
        success: false,
        message: technicalErrorText,
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> updateDisplayName(String newName) async {
    await _auth.currentUser?.updateDisplayName(newName);
  }

  Future<AuthStatus> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser?.updateEmail(newEmail);
      return AuthStatus(
        message: 'Адрес электронной почты успешно изменён',
      );
    } on FirebaseAuthException catch (e) {
      final String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Данный email недействителен';
          break;
        case 'email-already-in-use':
          message = 'Данный email уже используется';
          break;
        case requiresRecentLogin:
          message = 'Для выполнения дествия требуется переавторизация';
          break;
        default:
          message = technicalErrorText;
          break;
      }
      return AuthStatus(message: message, success: false, status: e.code);
    } catch (e) {
      return AuthStatus(
        message: technicalErrorText,
        success: false,
        status: technicalStatus,
      );
    }
  }

  Future<AuthStatus> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      return AuthStatus(
        message: 'Пароль успешно изменён',
      );
    } on FirebaseAuthException catch (e) {
      final String message;
      switch (e.code) {
        case 'weak-password':
          message = 'Данный пароль слишком слабый';
          break;
        case requiresRecentLogin:
          message = 'Для выполнения дествия требуется переавторизация';
          break;
        default:
          message = technicalErrorText;
          break;
      }
      return AuthStatus(success: false, message: message, status: e.code);
    } catch (e) {
      return AuthStatus(
        message: technicalErrorText,
        success: false,
        status: technicalStatus,
      );
    }
  }

  Future<AuthStatus> deleteUser() async {
    try {
      await _auth.currentUser?.delete();
      return AuthStatus(
        message: 'Пользователь успешно удалён',
      );
    } on FirebaseAuthException catch (e) {
      final String message;
      switch (e.code) {
        case requiresRecentLogin:
          message = 'Для выполнения дествия требуется переавторизация';
          break;
        default:
          message = technicalErrorText;
          break;
      }
      return AuthStatus(
        message: message,
        success: false,
        status: e.code,
      );
    } catch (e) {
      return AuthStatus(
        message: technicalErrorText,
        success: false,
        status: technicalStatus,
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
