import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

void main() => runApp(FuoApp());

class FuoApp extends StatelessWidget {
  static const py = const MethodChannel('io.github.feeluown/chaquopy');

  Future<void> _startPythonInstance() async {
    await py.invokeMethod('startPythonInstance');
  }

  @override
  Widget build(BuildContext context) {
    _startPythonInstance();
    return MaterialApp(
      title: 'FeelUOwn X',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: HomePage(),
    );
  }
}
