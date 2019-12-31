import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gonna',
      theme: ThemeData(
          primarySwatch: Colors.blue),
      home: HomePage(title: 'Gonna'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _createPlan() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => CreatePlanPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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

class CreatePlanPage extends StatefulWidget {
  CreatePlanPage({Key key}) : super(key: key);

  @override
  _CreatePlanPageState createState() => _CreatePlanPageState();
}

class _CreatePlanPageState extends State<CreatePlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Plan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create Plan Page Body',
            ),
          ],
        ),
      ),
    );
  }
}
