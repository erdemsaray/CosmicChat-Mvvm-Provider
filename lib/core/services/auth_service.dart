import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get currentUser => _auth.currentUser;

  Future<User?> signIn() async {
    var user = await _auth.signInAnonymously();

    return user.user;
  }

  void signOut(context) async {
    await _auth.signOut();
  }

  void updateLastConnectTime() async {
    await _firestore.collection('profile').doc(_auth.currentUser?.uid).update({
      'timeStamp': DateTime.now(),
    });
  }
}
