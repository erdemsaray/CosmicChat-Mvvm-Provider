import 'package:get_it/get_it.dart';

import '../core/services/auth_service.dart';
import '../core/services/chat_service.dart';
import '../models/conversation.dart';
import '../views/whatsapp_main.dart';
import 'base_model.dart';

class ChatsModel extends BaseModel {
  final ChatService _db = GetIt.instance<ChatService>();

  ChatsModel() {
    updateLastConnectTime();
  }

  Stream<List<Conversation>> conversations(String userId) {
    notifyListeners();
    return _db.getConversations(userId);
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

  void updateLastConnectTime() {
    AuthService().updateLastConnectTime();
  }
}
