import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart' as widgets;
import 'package:gonna_client/services/error.dart' as error;

void showErrorDialog(
    widgets.BuildContext context, error.UserVisibleError userVisibleError) {
  material.showDialog(
      context: context,
      builder: (_) => material.AlertDialog(
            title: widgets.Text('Error'),
            content: widgets.Text(userVisibleError.longMessage),
            actions: [
              material.TextButton(
                  child: material.Text('Okay, I will try again later :\'('),
                  onPressed: () => {material.Navigator.of(context).pop()}),
            ],
          ));
}
