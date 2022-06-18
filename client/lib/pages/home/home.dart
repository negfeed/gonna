import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart'
    as cached_network_image;
import 'package:gonna_client/pages/contacts/ContactsPage.dart';
import 'package:gonna_client/pages/contacts/UsersPage.dart';
import 'package:gonna_client/pages/create/create.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:gonna_client/services/contact_sync/contact_sync.dart'
    as contact_sync;
import 'package:gonna_client/services/database/app_state_dao.dart'
    as app_state_dao;
import 'package:gonna_client/services/storage/storage.dart' as storage;
import 'package:gonna_client/services/wipeout/wipeout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _createPlan() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => CreatePlanPage()));
  }

  void _openContacts() {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => ContactsPage()));
  }

  void _openUsers() {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => UsersPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gonna"),
      ),
      drawer: buildDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home Page Body',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPlan,
        tooltip: 'Create',
        child: Icon(Icons.add),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
        child: ListView(
      children: <Widget>[
        FutureBuilder<app_state_dao.UserInfo>(
            future: app_state_dao.AppStateDao.instance.getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                app_state_dao.UserInfo userInfo = snapshot.data!;
                return UserAccountsDrawerHeader(
                  accountName:
                      Text('${userInfo.firstName} ${userInfo.lastName}'),
                  accountEmail: Text(userInfo.phoneNumber!),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        cached_network_image.CachedNetworkImageProvider(storage
                            .StorageService.instance
                            .getProfilePictureUrl(
                                AuthService.instance.currentUser!.uid)),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('Awaiting result...');
              }
            }),
        ListTile(
          title: Text('Contacts (phone)'),
          onTap: _openContacts,
        ),
        ListTile(
          title: Text('Contacts (phone + profiles)'),
          onTap: _openUsers,
        ),
        ListTile(
          title: Text('Sync all contacts'),
          onTap: () =>
              contact_sync.ContactSyncService.instance.syncAllContacts(),
        ),
        ListTile(
          title: Text('Signout and Wipeout'),
          onTap: () => WipeoutService.signoutAndWipeoutDatabase(),
        ),
      ],
    ));
  }
}
