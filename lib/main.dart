import 'setting.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'home.dart';
import 'themes.dart' as themes;

void main() {
  runApp(FuoApp());
}

class FuoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FuoAppState();
}

class FuoAppState extends State<FuoApp> {
  String lightTheme = 'light';
  String darkTheme = 'black';
  AppSettings settings;

  @override
  void initState() {
    super.initState();
    StreamingSharedPreferences.instance.then((prefs) {
      settings = AppSettings(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (settings == null) {
      return MaterialApp(
        title: 'FeelUOwn X',
        theme: themes.themes[lightTheme],
        darkTheme: themes.themes[darkTheme],
        home: HomePage(),
      );
    }
    return PreferenceBuilder<bool>(
      preference: settings.forceDark,
      builder: (context, forceDark) => MaterialApp(
        title: 'FeelUOwn X',
        theme: themes.themes[forceDark ? darkTheme : lightTheme],
        darkTheme: themes.themes[darkTheme],
        home: HomePage(),
      ),
    );
  }
}
