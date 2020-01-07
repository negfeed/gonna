import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gonna',
      theme: ThemeData(primarySwatch: Colors.blue),
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

class _CreatePlanPageState extends State<CreatePlanPage>
    with TickerProviderStateMixin {
  Future<void> _showDatePicker() async {
    await showDatePicker(
        context: this.context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 10)));
  }

  Future<void> _showTimePicker() async {
    await showTimePicker(context: this.context, initialTime: TimeOfDay.now());
  }

  Future<void> _showDurationPicker() async {
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: [
          "1 hour",
          "2 hours",
          "3 hours",
          "4 hours",
          "5 hours",
          "6 hours",
          "7 hours",
          "8 hours"
        ]),
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Publish'),
        icon: Icon(Icons.publish),
      ),
      appBar: AppBar(
        title: Text('Create Plan'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hasFloatingPlaceholder: true,
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(thickness: 1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Date',
                hasFloatingPlaceholder: true,
                border: InputBorder.none,
              ),
              onTap: _showDatePicker,
              readOnly: true,
            ),
          ),
          Divider(thickness: 1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Start Time',
                hasFloatingPlaceholder: true,
                border: InputBorder.none,
              ),
              onTap: _showTimePicker,
              readOnly: true,
            ),
          ),
          Divider(thickness: 1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Duration',
                hasFloatingPlaceholder: true,
                border: InputBorder.none,
              ),
              onTap: _showDurationPicker,
              readOnly: true,
            ),
          ),
          Divider(thickness: 1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            child:
                new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Extra Notes',
                    hasFloatingPlaceholder: true,
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  minLines: null,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
