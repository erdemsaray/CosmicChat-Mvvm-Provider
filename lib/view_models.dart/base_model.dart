import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/services/locator.dart';
import '../core/services/navigator_service.dart';

abstract class BaseModel with ChangeNotifier {
  final NavigatorService navigatorService = getIt<NavigatorService>();
  User? user = FirebaseAuth.instance.currentUser;

  bool _busy = false;

  bool get busy => _busy;
  set busy(bool state) {
    _busy = state;
    notifyListeners();
  }
}
