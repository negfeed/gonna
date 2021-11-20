import 'package:contacts_service/contacts_service.dart' as contacts_service;
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart'
    as flutter_libphonenumber;
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart'
    as permission_interface;

class ContactsService {
  static ContactsService? _instance;

  static ContactsService get instance {
    if (_instance == null) {
      _instance = ContactsService();
    }
    return _instance!;
  }

  Future<bool> _checkContactsPermissionAndMaybeRequestPermission() async {
    print("Checking contacts permission.");
    permission_handler.PermissionStatus permission =
        await permission_interface.Permission.contacts.status;
    print("Contacts permission: $permission.");
    if (permission == permission_handler.PermissionStatus.granted) {
      return true;
    }
    print("Requesting contacts permission.");
    permission_handler.PermissionStatus newPermssion =
        await permission_interface.Permission.contacts.request();
    if (newPermssion == permission_handler.PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  _showContactsPermissionBlockingPrompt(material.BuildContext context) async {
    print("Requesting permissions didn't work!!! Show blocker dialog!!.");
    await material.showDialog(
        context: context,
        builder: (_) => material.AlertDialog(
              title: widgets.Text('Contacts Permission'),
              content: widgets.Text(
                  'This app requires access to contacts to function properly. '
                  'Please open the app system settings and enable its access '
                  'to Contacts.'),
              actions: [
                material.TextButton(
                    child: material.Text('Open app system settings'),
                    onPressed: () => {permission_handler.openAppSettings()}),
                material.TextButton(
                    child: material.Text('I gave the app access, let\'s go!'),
                    onPressed: () => {material.Navigator.of(context).pop()}),
              ],
            ));
  }

  requestContactsPermissionAndBlockProgressIfNotGiven(
      material.BuildContext context) async {
    bool permissionGranted = false;
    do {
      permissionGranted =
          await _checkContactsPermissionAndMaybeRequestPermission();
      if (permissionGranted) break;
      await _showContactsPermissionBlockingPrompt(context);
    } while (!permissionGranted);
  }

  Future<Map<String, contacts_service.Contact>>
      getE164PhoneNumberToContactMap() async {
    return contacts_service.ContactsService.getContacts(
            withThumbnails: false, photoHighResolution: false)
        .then((contacts) async {
      Map<String, contacts_service.Contact> map = {};
      for (var index = 0; index < contacts.length; ++index) {
        var contact = contacts[index];
        final phoneNumber = await _getE164PhoneNumber(contact);
        if (phoneNumber == null) continue;
        map[phoneNumber] = contact;
      }
      return map;
    });
  }

  Future<Map<String, contacts_service.Contact>>
      getPhoneNumberToContactsMap() async {
    return contacts_service.ContactsService.getContacts(
            withThumbnails: false, photoHighResolution: false)
        .then((contacts) => Map.fromEntries(contacts
            .where(_hasPhoneNumber)
            .map((contact) => MapEntry(_getPhoneNumber(contact), contact))));
  }

  static bool _hasPhoneNumber(contacts_service.Contact contact) {
    return (contact.phones?.where((phone) => phone.value != null).length ?? 0) >
        0;
  }

  Future<String?> _getE164PhoneNumber(contacts_service.Contact contact) async {
    if (contact.phones == null) {
      return Future.value(null);
    }

    return Future.wait(contact.phones!
            .where((phone) => phone.value != null)
            .map((phone) => _parseE164(phone.value!)))
        .then((e164PhoneNumbers) => e164PhoneNumbers
            .firstWhere((phone) => phone != null, orElse: () => null));
  }

  static String _getPhoneNumber(contacts_service.Contact contact) {
    return contact.phones!.firstWhere((phone) => phone.value != null).value
        as String;
  }

  Future<Set<String>> getPhoneNumbers() async {
    return contacts_service.ContactsService.getContacts(
            withThumbnails: false, photoHighResolution: false)
        .then((contacts) => _extractPhoneNumbersFromContactsList(contacts));
  }

  Future<Set<String>> _extractPhoneNumbersFromContactsList(
      List<contacts_service.Contact> contactsList) async {
    print('contacts count: ${contactsList.length}');
    final phoneNumbers = contactsList
        .map((contacts_service.Contact contact) =>
            contact.phones ?? List.empty())
        .expand((List<contacts_service.Item> phones) => phones)
        .where((contacts_service.Item phone) => phone.value != null)
        .map((contacts_service.Item phone) => phone.value!);
    print('phone numbers count: ${phoneNumbers.length}');

    final parsedPhoneNumbers = phoneNumbers.map(_parseE164);

    Future<Set<String>> e164Phones = Future.wait(parsedPhoneNumbers).then(
        (parsedNumbers) => parsedNumbers
            .where((e164) => e164 != null)
            .map((e164) => e164!)
            .toSet());
    e164Phones.then(
        (e164Phones) => print('extracted set count: ${e164Phones.length}'));

    return e164Phones;
  }

  Future<String?> _parseE164(String phoneNumber) async {
    var res;

    // TODO (mshamma): Make the parsing work for non-US phones.
    try {
      res = await flutter_libphonenumber.FlutterLibphonenumber().parse(
        phoneNumber,
        region: 'us',
      );
      return res['e164'];
    } on Exception {
      return null;
    }
  }
}
