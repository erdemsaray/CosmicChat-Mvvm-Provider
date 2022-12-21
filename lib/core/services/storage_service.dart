import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child("${DateTime.now().microsecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    return await (await uploadTask).ref.getDownloadURL();
  }
}
