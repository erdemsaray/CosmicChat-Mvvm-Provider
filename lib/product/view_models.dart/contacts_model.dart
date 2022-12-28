import 'package:firebase_auth/firebase_auth.dart';

import '../services/chat_service.dart';
import '../services/locator.dart';
import '../models/profile.dart';
import '../views/conversation_page.dart';
import 'base_model.dart';

class ContactsModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();
  List<Profile>? filteredContacts;
  String searchText = '';

  updateSearchText(String newText) {
    searchText = newText;
    getContacts();
    notifyListeners();
  }

  Future<List<Profile>?> getContacts() async {
    var contacts = await _chatService.getContacts();
    filteredContacts = contacts
        .where((profile) => profile.username.startsWith(searchText))
        .where((profile) => profile.id != user?.uid)
        .toList();

    notifyListeners();
    return filteredContacts;
  }

  Future<List<Profile>> getAllContacts() async {
    var contacts = await _chatService.getContacts();

    return contacts;
  }

  Future<void> startConversation(Profile profile) async {
    var conversation = await _chatService.startConversation(profile);
    User? user = FirebaseAuth.instance.currentUser;

    navigatorService.navigateTo(ConversationPage(userId: user!.uid, conversation: conversation));
  }
}
