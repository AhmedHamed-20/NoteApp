import 'package:firebase_auth/firebase_auth.dart';

class AuthFirbaseService {
  final FirebaseAuth _firebaseAuth;

  AuthFirbaseService(this._firebaseAuth);

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
