import 'package:cloud_firestore/cloud_firestore.dart';

import 'profile.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMessage;

  Conversation({required this.id, required this.name, required this.profileImage, required this.displayMessage});

  factory Conversation.fromSnaphot(DocumentSnapshot snapshot, Profile profile) {
    return Conversation(
        id: snapshot.id,
        name: profile.username,
        profileImage: profile.image,
        displayMessage: snapshot['displayMessage']);
  }
}
