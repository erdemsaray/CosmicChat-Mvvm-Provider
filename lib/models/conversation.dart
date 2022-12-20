import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMessage;

  Conversation({required this.id, required this.name, required this.profileImage, required this.displayMessage});

  factory Conversation.fromSnaphot(DocumentSnapshot snapshot) {
    return Conversation(
        id: snapshot.id,
        name: 'Dali',
        profileImage: 'https://placekitten.com/200/200',
        displayMessage: snapshot['displayMessage']);
  }
}
