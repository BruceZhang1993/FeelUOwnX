import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content, {int seconds = 3}) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(content),
    duration: Duration(seconds: seconds),
  ));
}
