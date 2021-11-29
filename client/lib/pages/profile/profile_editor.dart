import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:gonna_client/services/database/app_state_dao.dart'
    as app_state_dao;
import 'package:gonna_client/services/error.dart' as error;
import 'package:gonna_client/services/firestore/profile_firestore.dart' as profile_firestore;
import 'package:gonna_client/services/firestore/phone_firestore.dart' as phone_firestore;
import 'package:gonna_client/services/storage/storage.dart';
import 'package:gonna_client/widgets/error/error_dialog.dart' as error_dialog;
import 'package:gonna_client/widgets/profile_picture/profile_picture.dart';

class ProfileEditorPage extends StatefulWidget {
  @override
  _ProfileEditorPageState createState() => _ProfileEditorPageState();
}

class _ProfileEditorPageState extends State<ProfileEditorPage> {
  final _formKey = GlobalKey<FormState>();
  final ProfilePictureController _profilePictureController =
      ProfilePictureController();
  final ProfilePictureErrorController _profilePictureErrorController =
      ProfilePictureErrorController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _profilePictureController.dispose();
    _profilePictureErrorController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
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
                      controller: _firstNameController,
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
                      controller: _lastNameController,
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

  String? _validateFirstName(String? value) {
    if (value == null || value.length == 0) {
      return "Enter your first name.";
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.length == 0) {
      return "Enter your last name.";
    }
    return null;
  }

  void _onCreateProfile() async {
    bool errorsFound = false;
    if (!_formKey.currentState!.validate()) {
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
    try {
      await _createProfile(_profilePictureController.value!,
          _firstNameController.value.text, _lastNameController.value.text);
    } on error.UserVisibleError catch (error) {
      error_dialog.showErrorDialog(context, error);
    }
  }

  // TODO: Consider moving this method to a service class.
  // TODO: Consider applying the try/on/catch stanza systematically (code generation??).
  Future<void> _createProfile(File profilePicture, String firstName, String lastName) async {
    try {
      await AuthService.instance.maybeCreateAndSignInUsingDeviceAccount();
      await StorageService.instance.uploadProfilePicture(profilePicture);
      await profile_firestore.ProfileFirestoreService.instance.createProfile(firstName, lastName);
      await app_state_dao.AppStateDao.instance.setProfileData(firstName, lastName);
      await phone_firestore.PhoneFirestoreService.instance.createOrUpdatePhoneNumberProfileId();
      await app_state_dao.AppStateDao.instance.markPhoneNumberAsMappedToProfile();
    } on error.UserVisibleError catch (uve) {
      throw uve;
    } catch (e) {
      throw error.CatchAllError(e as Exception);
    }
  }
}
