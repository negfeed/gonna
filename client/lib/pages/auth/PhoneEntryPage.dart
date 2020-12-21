import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                onInputChanged: (phoneNumber) {},
                selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                    backgroundColor: Colors.white),
                countries: ['US', 'CA'],
                initialValue: PhoneNumber(isoCode: 'US'),
                autoFocus: true,
              ),
            ),
            RaisedButton(
              onPressed: () {},
              child: const Text('Verify'),
              padding: const EdgeInsets.all(20.0),
            ),
          ],
        ),
      ),
    );
  }
}
