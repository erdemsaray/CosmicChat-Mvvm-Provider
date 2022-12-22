import 'package:get_it/get_it.dart';

import '../core/services/chat_service.dart';
import '../models/conversation.dart';
import 'base_model.dart';

class ChatsModel extends BaseModel {
  final ChatService _db = GetIt.instance<ChatService>();

  Stream<List<Conversation>> conversations(String userId) {
    notifyListeners();
    return _db.getConversations(userId);
  }

  
}
