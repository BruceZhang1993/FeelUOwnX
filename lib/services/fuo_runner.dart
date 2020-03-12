import 'package:flutter/services.dart';

class FuoRunner {
  static const py = const MethodChannel('io.github.feeluown/chaquopy');
  static var fuoStarted = false;

  static Future<String> runDaemon() async {
    var res = 'done';
    if (!fuoStarted) {
       res = await py.invokeMethod('startFuoDaemon');
    }
    fuoStarted = true;
    return res;
  }

  static Future<void> startPythonInstance() async {
    await py.invokeMethod('startPythonInstance');
  }
}
