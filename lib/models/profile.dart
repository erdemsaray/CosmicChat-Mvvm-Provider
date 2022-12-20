// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String id;
  String username;
  String image;

  Profile(
    this.id,
    this.username,
    this.image,
  );

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(snapshot.id, snapshot["username"], snapshot["image"]);
  }
}
