import 'package:flutter/material.dart';
import 'package:gonna_client/pages/contacts/ContactsPage.dart';
import 'package:gonna_client/pages/create/create.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:gonna_client/services/background/background.dart';
import 'package:gonna_client/services/contact_sync/contact_sync.dart' as contact_sync;

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
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ContactsPage()));
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
        UserAccountsDrawerHeader(
          accountName: Text('TODO: Name'),
          accountEmail: Text('TODO: Email'),
        ),
        ListTile(
          title: Text('Contacts'),
          onTap: _openContacts,
        ),
        ListTile(
          title: Text('Sync all contacts (direct)'),
          onTap: () => contact_sync.ContactSyncService.instance.syncAllContacts(),
        ),
        ListTile(
          title: Text('Sync all contacts (background)'),
          onTap: () => BackgroundService.instance.syncAllContacts(),
        ),
        ListTile(
          title: Text('Sign Out'),
          onTap: () => AuthService.instance.signOut(),
        ),
        ListTile(
          title: Text('Delete Account'),
          onTap: () => AuthService.instance.deleteAccount(),
        ),
      ],
    ));
  }
}
