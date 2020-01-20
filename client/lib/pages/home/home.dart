import 'package:flutter/material.dart';
import 'package:gonna_client/pages/create/create.dart';
import 'package:gonna_client/services/auth/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _auth = AuthService();

  void _createPlan() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => CreatePlanPage()));
  }

  void _signOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gonna"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: _signOut,
            ),
          ],
        )
      ),
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
}

