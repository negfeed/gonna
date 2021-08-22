import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme_data.dart';

class ProfilePicture extends StatefulWidget {
  final ProfilePictureController controller;
  final ProfilePictureErrorController errorController;

  ProfilePicture({required this.controller, required this.errorController});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture>
    with SingleTickerProviderStateMixin {
  final picker = ImagePicker();

  late AnimationController _animationController;
  late Animation<Color?> animation;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_didChangeFileValue);
    widget.errorController.addListener(_playErrorAnimation);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    animation = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: themeData.primaryColorDark,
          end: themeData.errorColor,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: themeData.errorColor,
          end: themeData.primaryColorDark,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: themeData.primaryColorDark,
          end: themeData.errorColor,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: themeData.errorColor,
          end: themeData.primaryColorDark,
        ),
      ),
    ]).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  void _didChangeFileValue() {
    setState(() { /* We use widget.controller.value in build(). */ });
  }

  void _playErrorAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  dispose() {
    _animationController?.dispose();
    widget.controller.removeListener(_didChangeFileValue);
    widget.errorController.removeListener(_playErrorAnimation);
    super.dispose();
  }

  @override
  void didUpdateWidget(ProfilePicture oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_didChangeFileValue);
      widget.controller.addListener(_didChangeFileValue);
    }
    if (widget.errorController != oldWidget.errorController) {
      oldWidget.controller.removeListener(_playErrorAnimation);
      widget.controller.addListener(_playErrorAnimation);
    }
  }

  File? get _image => widget.controller.value;

  set _image(File? value) {
    widget.controller.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 100,
            child: _image == null ? Text("Add a profile picture") : null,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            backgroundColor: animation.value,
            foregroundColor: Colors.white,
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
    );
  }

  _cropImage(PickedFile pickedImage) async {
    File? cropped = await ImageCropper.cropImage(
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
      builder: (context) => AlertDialog(
        title: Text("Select Picture Source"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera_alt, size: 48),
              title: Text("Camera"),
              onTap: () {
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, size: 48),
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
}

class ProfilePictureController extends ValueNotifier<File?> {
  ProfilePictureController() : super(null);

  ProfilePictureController.fromValue(File value) : super(value);

  File? get value => super.value;

  @override
  set value(File? newValue) {
    super.value = newValue;
  }

  void clear() {
    value = null;
  }
}

class ProfilePictureErrorController extends ChangeNotifier {
  void playErrorAnimation() {
    notifyListeners();
  }
}
