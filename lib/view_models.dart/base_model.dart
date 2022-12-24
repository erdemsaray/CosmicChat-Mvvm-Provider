import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/services/auth_service.dart';
import '../core/services/locator.dart';
import '../core/services/navigator_service.dart';
import '../views/sign_in_page.dart';

abstract class BaseModel with ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();

  final NavigatorService navigatorService = getIt<NavigatorService>();
  User? user = FirebaseAuth.instance.currentUser;

  bool _busy = false;

  bool get busy => _busy;
  set busy(bool state) {
    _busy = state;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    busy = true;
    _authService.signOut(context);
    await navigatorService.navigateToReclace(const SignInPage());
    busy = false;
  }
}
