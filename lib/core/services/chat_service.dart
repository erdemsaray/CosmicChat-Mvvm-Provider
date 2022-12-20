import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/conversation.dart';
import '../../models/profile.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore.collection('conversations').where('members', arrayContains: userId);

    return ref.snapshots().map((list) => list.docs.map((snapshot) => Conversation.fromSnaphot(snapshot)).toList());
  }

  Future<List<Profile>> getContacts() async {
    var ref = _firestore.collection("profile");

    QuerySnapshot documents = await ref.get();

    return documents.docs.map((snapshot) => Profile.fromSnapshot(snapshot)).toList();
  }
}
