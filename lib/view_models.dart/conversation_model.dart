import 'package:cloud_firestore/cloud_firestore.dart';


class ConversationModel {
  
 
  late CollectionReference _ref;

  Stream<QuerySnapshot> getConversation(String id) {
    _ref = FirebaseFirestore.instance.collection('conversations/$id/messages');

    return _ref.orderBy('timeStamp').snapshots();
  }

  
}