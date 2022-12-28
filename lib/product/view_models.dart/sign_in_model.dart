import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/locator.dart';
import '../views/homepage.dart';
import 'base_model.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = getIt<AuthService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get currentUser => _authService.currentUser;

  Future<void> signIn(String username, String imageLink, BuildContext context) async {
    if (username.isEmpty || imageLink.isEmpty) return;
    busy = true;
    var user;
    try {
      user = await _authService.signIn();
      await _firestore.collection('profile').doc(user?.uid).set({
        'username': username,
        'image': imageLink,
        'timeStamp': DateTime.now(),
      });

      await navigatorService.navigateToReclace(HomePage());
      //hesaptan cıkıs yapmadan yeni hesap olusturdugumuz için :D
      //user id override ediliyor
    } catch (e) {
      busy = false;
    }

    busy = false;
  }

  Stream<QuerySnapshot> getCharacters() {
    var ref = _authService.getCharacters();

    return ref;
  }
}
