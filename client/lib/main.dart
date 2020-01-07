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
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _durationController = TextEditingController();

  final List<int> _durations = [1, 2, 3, 4, 5, 6, 7, 8];
  final List<String> _durationStrings = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _durations.length; i++) {
      if (_durations[i] == 1) {
        _durationStrings.add("${_durations[i]} hour");
      } else {
        _durationStrings.add("${_durations[i]} hours");
      }
    }
  }

  DateTime _date;
  TimeOfDay _time;
  Duration _duration;
  int _durationPickedIndex;

  String _nameValidator(String value) {
    if (value.length == 0) {
      return "Enter an event name.";
    }
    return null;
  }

  String _dateValidator(String value) {
    if (value.length == 0) {
      return "Choose a date.";
    }
    return null;
  }

  String _timeValidator(String value) {
    if (value.length == 0) {
      return "Choose a time.";
    }
    return null;
  }

  String _durationValidator(String value) {
    if (value.length == 0) {
      return "Choose duration.";
    }
    return null;
  }

  void _onPublishPlan() {
    if (_formKey.currentState.validate()) {
      print("Yay, validation passed!");
    }
  }

  Future<void> _showDatePicker() async {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    DateTime initialDate = _date != null ? _date : tomorrow;
    DateTime pickedDateTime = await showDatePicker(
        context: this.context,
        initialDate: initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 14)));
    if (pickedDateTime != null) {
      _date = pickedDateTime;
      _dateController.text =
          MaterialLocalizations.of(context).formatMediumDate(pickedDateTime);
    }
  }

  Future<void> _showTimePicker() async {
    TimeOfDay noon = TimeOfDay(hour: 12, minute: 0);
    TimeOfDay initialTime = _time != null ? _time : noon;
    TimeOfDay pickedTime =
    await showTimePicker(context: this.context, initialTime: initialTime);
    if (pickedTime != null) {
      _time = pickedTime;
      _timeController.text =
          MaterialLocalizations.of(context).formatTimeOfDay(pickedTime);
    }
  }

  Future<void> _showDurationPicker() async {
    var pickedIndex = _durationPickedIndex != null ? _durationPickedIndex : 0;
    new Picker(
        selecteds: [pickedIndex],
        adapter: PickerDataAdapter<String>(pickerdata: _durationStrings),
        hideHeader: true,
        title: new Text("Select Duration"),
        onConfirm: (Picker picker, List value) {
          _durationPickedIndex = picker.selecteds[0];
          _durationController.text = picker.getSelectedValues()[0];
          _duration = Duration(hours: _durations[_durationPickedIndex]);
          print(value.toString());
          print(picker.getSelectedValues());
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onPublishPlan,
        label: Text('Publish'),
        icon: Icon(Icons.publish),
      ),
      appBar: AppBar(
        title: Text('Create Plan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hasFloatingPlaceholder: true,
                  border: InputBorder.none,
                ),
                validator: _nameValidator,
              ),
            ),
            Divider(thickness: 1),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date',
                  hasFloatingPlaceholder: true,
                  border: InputBorder.none,
                ),
                onTap: _showDatePicker,
                readOnly: true,
                controller: _dateController,
                validator: _dateValidator,
              ),
            ),
            Divider(thickness: 1),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Start Time',
                  hasFloatingPlaceholder: true,
                  border: InputBorder.none,
                ),
                onTap: _showTimePicker,
                readOnly: true,
                controller: _timeController,
                validator: _timeValidator,
              ),
            ),
            Divider(thickness: 1),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Duration',
                  hasFloatingPlaceholder: true,
                  border: InputBorder.none,
                ),
                onTap: _showDurationPicker,
                readOnly: true,
                controller: _durationController,
                validator: _durationValidator,
              ),
            ),
            Divider(thickness: 1),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              child:
              new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: TextFormField(
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
      ),
    );
  }
}
