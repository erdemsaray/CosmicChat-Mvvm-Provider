import '../core/services/auth_service.dart';
import '../models/conversation.dart';
import '../models/profile.dart';
import '../views/whatsapp_main.dart';
import 'base_model.dart';

class ChatsModel extends BaseModel {
  Profile? filteredContact;

  ChatsModel() {
    getUser();
    updateLastConnectTime();
  }

  Stream<List<Conversation>> conversations(String userId) {
    notifyListeners();
    return chatService.getConversations(userId);
  }

  Future<void> goContactPage() async {
    busy = true;

    await navigatorService.navigateToReclace(WhatsappMain(
      initialIndex: 1,
    ));
    //hesaptan cıkıs yapmadan yeni hesap olusturdugumuz için :D
    //user id override ediliyor

    busy = false;
  }

  Future<Profile?> getUser() async {
    var contacts = await chatService.getContacts();
    filteredContact = contacts.where((profile) => profile.id == user?.uid).first;

    notifyListeners();
    return filteredContact;
  }

  void updateLastConnectTime() {
    AuthService().updateLastConnectTime();
  }
}
