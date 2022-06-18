import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:gonna_client/services/flavor/flavor.dart' as flavor;

class StorageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  static StorageService? _instance;
  final auth.AuthService _auth = auth.AuthService.instance;

  static StorageService get instance {
    if (_instance == null) {
      _instance = StorageService();
    }
    return _instance!;
  }

  Future<void> uploadProfilePicture(File profilePicture) async {
    if (_auth.currentUser == null) {
      throw new Exception(
          'Cant upload profile photo without authenticated user.');
    }
    await _storage
        .ref('profileImage/${_auth.currentUser!.uid}')
        .putFile(profilePicture);
    ;
    print('Finished uploading the image');
  }

  String getProfilePictureThumbnailUrl(String profileId) {
    return flavor.FlavorConfig.instance.storageUrlBase +
        'profileImage-thumbnails%2F$profileId?alt=media';
  }

  String getProfilePictureUrl(String profileId) {
    return flavor.FlavorConfig.instance.storageUrlBase +
        'profileImage-profiles%2F$profileId?alt=media';
  }
}
