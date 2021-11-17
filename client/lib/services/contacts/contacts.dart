import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart' as widgets;
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

  requestContactsPermissionAndBlockProgressIfNotGiven(material.BuildContext context) async {
    bool permissionGranted = false;
    do {
      permissionGranted =
          await _checkContactsPermissionAndMaybeRequestPermission();
      if (permissionGranted) break;
      await _showContactsPermissionBlockingPrompt(context);
    } while (!permissionGranted);
  }

  Future<Set<String>> getPhoneNumbers() async {
    // TODO: Implement.
    return Future.value(Set.of(['12', '23']));
  }
}
