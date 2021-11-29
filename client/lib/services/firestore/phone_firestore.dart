import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:flutter/foundation.dart' as foundation;
import 'package:gonna_client/preference_util.dart' as preference_util;
import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart'
    as shared_preferences;

const phoneDirectoryUpdatedPrefKey = "phone-phoneDirectoryUpdated";

class PhoneFirestoreService extends foundation.ChangeNotifier {
  cloud_firestore.FirebaseFirestore _firestore =
      cloud_firestore.FirebaseFirestore.instance;
  final auth.AuthService _auth = auth.AuthService.instance;
  final shared_preferences.SharedPreferences _preferences =
      preference_util.PreferenceUtil.instance;

  static PhoneFirestoreService? _instance;

  static PhoneFirestoreService get instance {
    if (_instance == null) {
      _instance = PhoneFirestoreService();
    }
    return _instance!;
  }

  Future<void> createOrUpdatePhoneNumberProfileId() async {
    if (_auth.currentUser == null ||
        _auth.currentUser!.getSignInProvider() != auth.SignInProvider.device) {
      throw Exception('Current auth user should be a device authenticated user.');
    }
    var profileId = _auth.currentUser!.uid;
    var phoneNumber = _auth.currentUser!.phoneNumber!;

    cloud_firestore.CollectionReference phoneNumbers =
        _firestore.collection('phones');

    // Read phone number document.
    var phoneDocRef = await phoneNumbers.doc(phoneNumber).get();
    Map<String, dynamic> phoneDoc = {};
    if (phoneDocRef.exists) {
      phoneDoc = phoneDocRef.data() as Map<String, dynamic>;
    }

    // Update the phone number document.
    phoneDoc['profileId'] = profileId;

    // Write the updated phone number document.
    await phoneNumbers.doc(phoneNumber).set(phoneDoc);

    // Update the local preference to indicate the directory update completed successfully.
    await _preferences.setBool(phoneDirectoryUpdatedPrefKey, true);

    // Notify the app state service of the change, possibly indicating the
    // home screen is ready to be displayed to the user.
    notifyListeners();
  }

  Map<String, String> resolvePhoneNumbersToProfileIds(
      List<String> phoneNumbers) {
    // TODO(mshamma): Implement.
    return {};
  }

  bool isPhoneDirectoryUpdated() {
    if (!_preferences.containsKey(phoneDirectoryUpdatedPrefKey)) {
      return false;
    }
    return _preferences.getBool(phoneDirectoryUpdatedPrefKey)??false;
  }
}
