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
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(234, 237, 221, 1.0),
        accentColor: Colors.amberAccent,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            color: Colors.black87,
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          bodyText1: TextStyle(
            color: Colors.black87,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
          bodyText2: TextStyle(
            color: Colors.black87,
            fontSize: 10.0,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      darkTheme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        accentColor: Colors.deepPurpleAccent,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white70,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            color: Colors.white70,
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          bodyText1: TextStyle(
            color: Colors.white70,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
          bodyText2: TextStyle(
            color: Colors.white70,
            fontSize: 10.0,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
