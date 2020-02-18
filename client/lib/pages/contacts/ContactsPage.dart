import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  ContactListItem(this.contact);

  String _abbreviation(String displayName) {
    var abbreviation = "";
    if (displayName == null) {
      return abbreviation;
    }
    if (displayName.length > 2) {
      abbreviation =
          displayName[0].toUpperCase() + displayName[1].toUpperCase();
    } else if (displayName.length == 1) {
      abbreviation = displayName[0].toUpperCase();
    }
    return abbreviation;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (contact.avatar != null)
          ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar))
          : CircleAvatar(
              child: Text(_abbreviation(contact.displayName),
                  style: TextStyle(color: Colors.white)),
            ),
      title: Text(contact.displayName ?? ""),
    );
  }
}

class ContactsList extends StatelessWidget {
  final Iterable<Contact> contacts;

  ContactsList(this.contacts);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (var contact in contacts) {
      list.add(ContactListItem(contact));
      list.add(Divider(
        thickness: 1,
      ));
    }
    return ListView(
      children: list,
    );
  }
}

class AppContactsPermissionException implements Exception {}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  _checkContactsPermissionAndMaybeRequestPermission() async {
    print("Checking contacts permission.");
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    print("Contacts permission: ${permission}.");
    if (permission == PermissionStatus.granted) {
      return;
    }
    print("Requesting contacts permission.");
    Map<PermissionGroup, PermissionStatus> permissionMap =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
    if (permissionMap[PermissionGroup.contacts] != PermissionStatus.granted) {
      print("Requesting permissions didn't work!!! Throwing exception.");
      throw new AppContactsPermissionException();
    }
  }

  Future<Iterable<Contact>> _loadContacts() async {
    await _checkContactsPermissionAndMaybeRequestPermission();
    return ContactsService.getContacts();
  }

  _openAppSettings() {
    PermissionHandler().openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: FutureBuilder<Iterable<Contact>>(
          future: _loadContacts(),
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<Contact>> snapshot) {
            List<Widget> noDataWidgets = [];
            if (snapshot.hasData) {
              return ContactsList(snapshot.data);
            } else if (snapshot.hasError) {
              if (snapshot.error is AppContactsPermissionException) {
                noDataWidgets.addAll([
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'You must give this app contacts permission to help ' +
                          'connect you to others. Click the button below, ' +
                          'then give the application permission to ' +
                          'access contacts.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  RaisedButton(
                      onPressed: () => _openAppSettings(),
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: const Text(
                        'Open Application Settings',
                      )),
                ]);
              } else {
                noDataWidgets.add(Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}.'),
                ));
              }
            } else {
              noDataWidgets.addAll([
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ]);
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: noDataWidgets,
              ),
            );
          },
        ));
  }
}
