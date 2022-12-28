import '../models/conversation.dart';
import '../models/profile.dart';
import '../services/auth_service.dart';
import '../views/homepage.dart';
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

    await navigatorService.navigateToReclace(HomePage(
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
