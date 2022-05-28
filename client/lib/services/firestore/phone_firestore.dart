import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:flutter/foundation.dart' as foundation;
import 'package:gonna_client/preference_util.dart' as preference_util;
import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart'
    as shared_preferences;
import 'package:gonna_client/services/firestore/phone.dart';

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
      throw Exception(
          'Current auth user should be a device authenticated user.');
    }
    var profileId = _auth.currentUser!.uid;
    var phoneNumber = _auth.currentUser!.phoneNumber!;

    cloud_firestore.CollectionReference phoneNumbers =
        _firestore.collection('phones');

    // Read phone number document.
    var phoneDocRef = await phoneNumbers.doc(phoneNumber).get();
    Phone phoneDoc = Phone();
    if (phoneDocRef.exists) {
      phoneDoc = Phone.fromJson(phoneDocRef.data() as Map<String, dynamic>);
    }

    // Update the phone number document.
    phoneDoc.profileId = profileId;

    // Write the updated phone number document.
    await phoneNumbers.doc(phoneNumber).set(phoneDoc.toJson());

    // Update the local preference to indicate the directory update completed successfully.
    await _preferences.setBool(phoneDirectoryUpdatedPrefKey, true);

    // Notify the app state service of the change, possibly indicating the
    // home screen is ready to be displayed to the user.
    notifyListeners();
  }

  Future<Map<String, String>> resolvePhoneNumbersToProfileIds(
      List<String> phoneNumbers) async {
    return _firestore
        .collection('phones')
        .where('__name__', whereIn: phoneNumbers)
        .get()
        .then((querySnapshot) => Map.fromIterable(
            querySnapshot.docs
                .where((d) => Phone.fromJson(d.data()).profileId != null),
            key: (d) => d.id,
            value: (d) => Phone.fromJson(d.data()).profileId!));
  }

  bool isPhoneDirectoryUpdated() {
    if (!_preferences.containsKey(phoneDirectoryUpdatedPrefKey)) {
      return false;
    }
    return _preferences.getBool(phoneDirectoryUpdatedPrefKey) ?? false;
  }
}
