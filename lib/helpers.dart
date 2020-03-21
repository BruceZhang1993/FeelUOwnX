import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content, {int seconds = 3}) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(content),
    duration: Duration(seconds: seconds),
  ));
}

Future<String> getTextDialog(BuildContext context, String title, String hint) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          title, style: Theme.of(context).textTheme.bodyText1,
        ),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: hint),
          ),
        ],
      );
    },
  );
}
