import '../core/services/chat_service.dart';
import '../core/services/locator.dart';
import '../models/profile.dart';
import 'base_model.dart';

class ContactsModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();

  Future<List<Profile>> getContacts(String? query) async {
    var contacts = await _chatService.getContacts();
    var filteredContacts = contacts.where((profile) => profile.username.startsWith(query ?? "")).toList();

    return filteredContacts;
  }

  Future<List<Profile>> getAllContacts() async {
    var contacts = await _chatService.getContacts();

    print(contacts[0].username);
    return contacts;
  }
}
