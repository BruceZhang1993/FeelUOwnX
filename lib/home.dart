import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import 'helpers.dart';
import 'services/fuo_runner.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'pages/pages.dart' as pages;
import 'services/playback.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Duration duration;
  Duration position;
  PlayerState playerState;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  initAudioPlayer() {
    PlaybackService.audioPlayer.setDurationHandler((Duration d) => setState(() { duration = d; }));
    PlaybackService.audioPlayer.setPositionHandler((Duration p) => setState(() { position = p; }));
    PlaybackService.audioPlayer.setErrorHandler((String msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
    PlaybackService.audioPlayer.setCompletionHandler(() {
      setState(() {
        playerState = PlayerState.stopped;
        position = duration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: GFAppBar(
        title: Text(
          'FeelUOwn X',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      drawer: GFDrawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GFDrawerHeader(
              child: Text(
                'FeelUOwn X',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Start Daemon'),
                      onTap: () {
                        FuoRunner.runDaemon(context);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Audio Test'),
                      onTap: () async {
                        String docDir = (await getApplicationDocumentsDirectory()).path;
                        if (!(await File('$docDir/demo.mp3').exists())) {
                          ByteData data = await DefaultAssetBundle.of(context).load('assets/demo/demo.mp3');
                          await File('$docDir/demo.mp3').writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
                        }
                        PlaybackService.startPlay(File('$docDir/demo.mp3').path, isLocal: true);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      body: pages.HomePage(),
    );
  }
}
