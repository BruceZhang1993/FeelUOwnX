import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(FuoApp());
}

class FuoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FeelUOwn X',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(234, 237, 221, 1.0),
        accentColor: Colors.amberAccent,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            color: Colors.black54,
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          bodyText1: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        accentColor: Colors.blueGrey,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white30,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            color: Colors.white30,
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          bodyText1: TextStyle(
            color: Colors.white30,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
