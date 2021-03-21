import 'package:flutter/material.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:gonna_client/services/error.dart';
import 'package:gonna_client/widgets/user_visible_error.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final AuthService _auth = AuthService.instance;

  UserVisibleError _error;
  TextEditingController _textEditingController;
  PinFieldAutoFill _pinFieldAutoFill;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _pinFieldAutoFill = PinFieldAutoFill(
      keyboardType: TextInputType.number,
      autofocus: true,
      onCodeChanged: (code) => _onCodeChanged(code),
      controller: _textEditingController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'We sent you an SMS message with a code. ' +
                    'Once you receive the code please enter it below ...',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _pinFieldAutoFill,
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: UserVisibleErrorMessage(error: _error),
              ),
          ],
        ),
      ),
    );
  }

  _onCodeChanged(String code) async {
    if (code.length == 1) {
      if (_error != null) {
        setState(() {
          _error = null;
        });
      }
    }
    if (code.length == 6) {
      print("submitted sms code $code");
      try {
        await _auth.submitSmsCode(code);
      } on UserVisibleError catch (e) {
        setState(() {
          _error = e;
        });
      } finally {
        _textEditingController.clear();
      }
    }
  }
}
