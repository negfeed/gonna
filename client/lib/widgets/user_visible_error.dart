import 'package:flutter/material.dart';
import 'package:gonna_client/services/error.dart';

class UserVisibleErrorMessage extends StatelessWidget {
  const UserVisibleErrorMessage({
    Key key,
    @required UserVisibleError error,
  })  : _error = error,
        super(key: key);

  final UserVisibleError _error;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.red),
        Text(_error.shortMessage, style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
