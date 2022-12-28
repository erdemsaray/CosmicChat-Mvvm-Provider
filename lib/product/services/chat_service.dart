import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../models/conversation.dart';
import '../models/profile.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore.collection('conversations').where('members', arrayContains: userId);

    var conversationsStream = ref.snapshots();
    var profilesStreams = getContacts().asStream();

    return Rx.combineLatest2(
        conversationsStream,
        profilesStreams,
        (QuerySnapshot conversations, List<Profile> profiles) => conversations.docs.map((snapshot) {
              List<String> members = List.from(snapshot['members']);

              var profile =
                  profiles.firstWhere((element) => element.id == members.firstWhere((element) => element != userId));

              return Conversation.fromSnaphot(snapshot, profile);
            }).toList());
  }

  Future<List<Profile>> getContacts() async {
    var ref = _firestore.collection("profile").orderBy('timeStamp', descending: true);

    QuerySnapshot documents = await ref.get();

    return documents.docs.map((snapshot) => Profile.fromSnapshot(snapshot)).toList();
  }

  

  Future<void> updateConservationDisplay(String conservationId, String displayMessage) async {
    var ref = _firestore.collection('conversations').doc(conservationId);

    await ref.update({'displayMessage': displayMessage});
  }

  Future<Conversation> startConversation(Profile profile) async {
    User? user = FirebaseAuth.instance.currentUser;
    var documentRef;
    var ref = _firestore.collection('conversations');

    var equalConversations = (await ref.where('members', isEqualTo: [user?.uid, profile.id]).get()).docs;

    if (equalConversations.isEmpty) {
      documentRef = await ref.add({
        'displayMessage': '',
        'members': [user?.uid, profile.id],
        'members2': 'sadasd'
      });
    } else {
      documentRef = equalConversations.first;
    }

    return Conversation(id: documentRef.id, name: profile.username, profileImage: profile.image, displayMessage: '');
  }
}
