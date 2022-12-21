import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../core/services/chat_service.dart';
import '../core/services/locator.dart';
import '../core/services/storage_service.dart';
import 'base_model.dart';

class ConversationModel extends BaseModel {
  final StorageService _storageService = getIt();
  late CollectionReference _ref;
  String mediaUrl = '';
  final ChatService _chatService = getIt<ChatService>();

  Stream<QuerySnapshot> getConversation(String id) {
    _ref = FirebaseFirestore.instance.collection('conversations/$id/messages');
    notifyListeners();
    return _ref.orderBy('timeStamp').snapshots();
  }

  Future<void> updateConservationDisplay(String conservationId, String displayMessage) async {
    await _chatService.updateConservationDisplay(conservationId, displayMessage);
  }

  Future<DocumentReference> add(Map<String, dynamic> data, String conservationId) async {
    mediaUrl = '';

    await updateConservationDisplay(conservationId, data['message']);
    notifyListeners();
    return _ref.add(data);
  }

  uploadMedia(ImageSource source) async {
    var pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return;

    mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));

    notifyListeners();
  }
}
