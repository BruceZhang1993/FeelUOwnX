import 'package:flutter/services.dart';

class FuoRunner {
  static const py = const MethodChannel('io.github.feeluown/chaquopy');

  static Future runDaemon() async {
    await py.invokeMethod('startFuoDaemon');
  }
}
