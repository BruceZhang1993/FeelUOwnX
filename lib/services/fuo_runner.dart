import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers.dart';
import '../models/models.dart' as models;
import 'fuo_client.dart';

class FuoRunner {
  static const py = const MethodChannel('io.github.feeluown/chaquopy');
  static bool fuoStarted = false;

  static Future<String> runDaemon(BuildContext context) async {
    var res = 'done';
    if (!fuoStarted) {
      res = await py.invokeMethod('startFuoDaemon');
      showSnackBar(context, 'FeelUOwn daemon started.');
    }
    fuoStarted = true;
    return res;
  }

  static Future<FuoClient> initConnection(BuildContext context) async {
    FuoClient client = await FuoClient(context).connect();
    return client;
  }

  static Future<List<models.Song>> searchSongs(BuildContext context, String query) async {
    FuoClient client = await initConnection(context);
    String response = await client.send(['search', '\'' + query + '\'']).catchError((err) {
      print('Something wrong happened.');
    });
    print(response.split(RegExp(r'\r?\n')));
    return response.split(RegExp(r'\r?\n'))
      .where((String element) => element.startsWith('fuo://'))
      .map((String element) => models.Song.fromString(element)).toList();
  }

  static Future<models.SongDetail> getSongDetail(BuildContext context, models.Song song) async {
    FuoClient client = await initConnection(context);
    String response = await client.send(['show', song.fuoUri]).catchError((err) {
      print('Something wrong happened.');
    });
    print(response.split(RegExp(r'\r?\n')));
    return models.SongDetail.fromString(response);
  }
}
