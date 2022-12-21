import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../core/services/auth_service.dart';
import '../core/services/chat_service.dart';
import '../core/services/locator.dart';
import '../models/conversation.dart';
import '../screens/sign_in_page.dart';
import 'base_model.dart';

class ChatsModel extends BaseModel {
  final ChatService _db = GetIt.instance<ChatService>();
  final AuthService _authService = getIt<AuthService>();

  Stream<List<Conversation>> conversations(String userId) {
    notifyListeners();
    return _db.getConversations(userId);
  }

  Future<void> signOut(BuildContext context) async {
    _authService.signOut(context);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignInPage(),
    ));
  }
}
