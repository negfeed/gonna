import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditorPage extends StatefulWidget {
  @override
  _ProfileEditorPageState createState() => _ProfileEditorPageState();
}

class _ProfileEditorPageState extends State<ProfileEditorPage> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

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
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 100,
                                child: _image == null
                                    ? Text("Add a profile picture")
                                    : null,
                                backgroundImage:
                                _image != null ? FileImage(_image) : null,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: RawMaterialButton(
                                    onPressed: () {
                                      _showImagePickOptionsDialog(context);
                                    },
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      size: 20.0,
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                    constraints: BoxConstraints(minWidth: 0)),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  _cropImage(PickedFile pickedImage) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle: CropStyle.circle,
    );
    if (cropped != null) {
      setState(() {
        _image = cropped;
      });
    }
  }

  _pickImage(ImageSource imageSource) async {
    final pickedImage = await picker.getImage(
        source: imageSource, preferredCameraDevice: CameraDevice.front);

    if (pickedImage != null) {
      _cropImage(pickedImage);
    }

    Navigator.pop(context);
  }

  void _showImagePickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Select Picture Source"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: IconButton(
                      iconSize: 48, icon: Icon(Icons.camera_alt)),
                  title: Text("Camera"),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading:
                  IconButton(iconSize: 48, icon: Icon(Icons.photo_library)),
                  title: Text("Photo Library"),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
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
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (_image == null) {
      // TODO: Add avatar editor error indicator.
    }
    print("Yay, validation passed!");
  }
}
