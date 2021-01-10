import 'package:flutter/material.dart';
import 'package:gonna_client/services/app_state/AppState.dart';
import 'package:gonna_client/services/app_state/InheritedAppState.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneEntryPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  PhoneNumber _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
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
                    print("phone number dial code: ${phoneNumber.dialCode}}");
                    print("phone number iso code: ${phoneNumber.isoCode}");
                    _phoneNumber = phoneNumber;
                  },
                  selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                      backgroundColor: Colors.white),
                  countries: ['US', 'CA'],
                  initialValue: PhoneNumber(isoCode: 'US'),
                  autoFocus: true,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _verifyPhoneNumber(context);
                },
                child: const Text('Verify'),
                padding: const EdgeInsets.all(20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyPhoneNumber(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _auth.verifyPhoneNumber(_phoneNumber.phoneNumber);
      AppState appState = InheritedAppState.of(context).appState;
      appState.submitPhoneNumber();
    }
  }
}
