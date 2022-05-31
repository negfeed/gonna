import 'package:flutter/material.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:gonna_client/services/error.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:gonna_client/widgets/user_visible_error.dart';

class PhoneEntryPage extends StatefulWidget {
  @override
  _PhoneEntryPageState createState() => _PhoneEntryPageState();
}

class _PhoneEntryPageState extends State<PhoneEntryPage> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService.instance;

  PhoneNumber? _phoneNumber;
  UserVisibleError? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Enter your phone number:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (phoneNumber) {
                        print("phone number: $phoneNumber}");
                        print(
                            "phone number dial code: ${phoneNumber.dialCode}}");
                        print("phone number iso code: ${phoneNumber.isoCode}");
                        _phoneNumber = phoneNumber;
                      },
                      selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DROPDOWN),
                      countries: ['US', 'CA'],
                      initialValue: PhoneNumber(isoCode: 'US'),
                      autoFocus: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _verifyPhoneNumber(context);
                    },
                    child: const Text('Verify'),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 40))),
                  ),
                ],
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: UserVisibleErrorMessage(error: _error!),
              ),
          ],
        ),
      ),
    );
  }

  void _verifyPhoneNumber(BuildContext context) async {
    setState(() {
      _error = null;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.verifyPhoneNumber(_phoneNumber!.phoneNumber!);
      } on UserVisibleError catch (error) {
        setState(() {
          _error = error;
        });
      }
    }
  }
}
