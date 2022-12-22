import 'package:firebase_auth/firebase_auth.dart';

import '../core/services/chat_service.dart';
import '../core/services/locator.dart';
import '../models/profile.dart';
import '../views/conversation_page.dart';
import 'base_model.dart';

class ContactsModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();
  String searchText = '';

  updateSearchText(String newText) {
    searchText = newText;
  }

  Future<List<Profile>> getContacts() async {
    var contacts = await _chatService.getContacts();
    var filteredContacts = contacts
        .where((profile) => profile.username.startsWith(searchText))
        .where((profile) => profile.id != user?.uid)
        .toList();

    notifyListeners();
    return filteredContacts;
  }

  Future<List<Profile>> getAllContacts() async {
    var contacts = await _chatService.getContacts();

    print(contacts[0].username);
    return contacts;
  }

  Future<void> startConversation(Profile profile) async {
    var conversation = await _chatService.startConversation(profile);
    User? user = FirebaseAuth.instance.currentUser;

    navigatorService.navigateTo(ConversationPage(userId: user!.uid, conversation: conversation));
  }
}
