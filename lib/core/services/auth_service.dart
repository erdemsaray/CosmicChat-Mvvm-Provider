import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn() async {
    var user = await _auth.signInAnonymously();

    return user.user;
  }
}
