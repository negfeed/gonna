import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gonna_client/services/auth/auth.dart' as auth;

class StorageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  static StorageService _instance;
  final auth.AuthService _auth = auth.AuthService.instance;

  static StorageService get instance {
    if (_instance == null) {
      _instance = StorageService();
    }
    return _instance;
  }

  void uploadProfilePicture(File profilePicture) async {
    await _storage.ref('profileImage/${_auth.currentUser.uid}').putFile(profilePicture);
    print('Finished uploading the image');
  }
}