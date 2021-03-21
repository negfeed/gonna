import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gonna_client/widgets/profile_picture/profile_picture.dart';

class ProfileEditorPage extends StatefulWidget {
  @override
  _ProfileEditorPageState createState() => _ProfileEditorPageState();
}

class _ProfileEditorPageState extends State<ProfileEditorPage> {
  final _formKey = GlobalKey<FormState>();
  ProfilePictureController _profilePictureController;
  ProfilePictureErrorController _profilePictureErrorController;

  @override
  void initState() {
    super.initState();
    _profilePictureController = ProfilePictureController();
    _profilePictureErrorController = ProfilePictureErrorController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ProfilePicture(
                        controller: _profilePictureController,
                        errorController: _profilePictureErrorController,
                      )),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: _validateFirstName,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: _validateLastName,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
                  ElevatedButton(
                    onPressed: _onCreateProfile,
                    child: const Text('Create Profile'),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20.0)),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  String _validateFirstName(String value) {
    if (value.length == 0) {
      return "Enter your first name.";
    }
    return null;
  }

  String _validateLastName(String value) {
    if (value.length == 0) {
      return "Enter your last name.";
    }
    return null;
  }

  void _onCreateProfile() {
    bool errorsFound = false;
    if (!_formKey.currentState.validate()) {
      errorsFound = true;
    }
    if (_profilePictureController.value == null) {
      _profilePictureErrorController.playErrorAnimation();
      errorsFound = true;
    }
    if (errorsFound) {
      return;
    }
    print("Yay, validation passed!");
  }
}
