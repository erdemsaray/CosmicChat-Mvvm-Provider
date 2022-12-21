import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/services/auth_service.dart';
import '../core/services/locator.dart';
import '../whatsapp_main.dart';
import 'base_model.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = getIt<AuthService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get currentUser => _authService.currentUser;

  Future<void> signIn(String username, BuildContext context) async {
    if (username.isEmpty) return;
    busy = true;
    var user;
    try {
      user = await _authService.signIn();
      await _firestore
          .collection('profile')
          .doc(user?.uid)
          .set({'username': username, 'image': 'https://placekitten.com/200/200'});

      await navigatorService.navigateToReclace(const WhatsappMain());
      //hesaptan cıkıs yapmadan yeni hesap olusturdugumuz için :D
      //user id override ediliyor
    } catch (e) {
      busy = false;
    }

    busy = false;
  }
}
