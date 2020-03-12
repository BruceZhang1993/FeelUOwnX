import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/fuo_runner.dart';
import 'home.dart';

void main() {
  runApp(FuoApp());
}

class FuoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FuoRunner.startPythonInstance();
    return MaterialApp(
      title: 'FeelUOwn X',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: HomePage(),
    );
  }
}
