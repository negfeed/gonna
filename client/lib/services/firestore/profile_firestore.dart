import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:flutter/foundation.dart' as foundation;
import 'package:gonna_client/preference_util.dart' as preference_util;
import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:gonna_client/services/firestore/profile.dart';
import 'package:shared_preferences/shared_preferences.dart'
    as shared_preferences;

const profileFirstNamePrefKey = "profile-firstName";
const profileLastNamePrefKey = "profile-lastName";

class ProfileFirestoreService extends foundation.ChangeNotifier {
  cloud_firestore.FirebaseFirestore _firestore =
      cloud_firestore.FirebaseFirestore.instance;
  final auth.AuthService _auth = auth.AuthService.instance;
  final shared_preferences.SharedPreferences _preferences =
      preference_util.PreferenceUtil.instance;

  static ProfileFirestoreService? _instance;

  static ProfileFirestoreService get instance {
    if (_instance == null) {
      _instance = ProfileFirestoreService();
    }
    return _instance!;
  }

  Future<String> createProfile(String firstName, String lastName) async {
    if (_auth.currentUser == null) {
      throw new Exception('Cant create profile without authenticated user.');
    }
    cloud_firestore.CollectionReference profiles =
        _firestore.collection('profiles');
    await profiles
        .doc('${_auth.currentUser!.uid}')
        .set(Profile(firstName, lastName).toJson());
    await _preferences.setString(profileFirstNamePrefKey, firstName);
    await _preferences.setString(profileLastNamePrefKey, lastName);
    print('Added profile to the profiles collection.');
    notifyListeners();
    return _auth.currentUser!.uid;
  }

  Future<Profile?> lookupProfile(String profileId) {
    return _firestore.collection('profiles').doc(profileId).get().then((snapshot) {
      if (snapshot.exists) {
        notifyListeners();
        return Profile.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  bool isProfileInitialized() {
    return _preferences.getString(profileFirstNamePrefKey) != null &&
        _preferences.getString(profileLastNamePrefKey) != null;
  }
}
