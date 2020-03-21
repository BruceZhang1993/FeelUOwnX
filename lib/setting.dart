import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AppSettings {
  AppSettings(StreamingSharedPreferences preferences)
      :
        daemonIp = preferences.getString('daemonIp', defaultValue: '127.0.0.1'),
        forceDark = preferences.getBool('forceDark', defaultValue: false);

  final Preference<String> daemonIp;
  final Preference<bool> forceDark;
}
