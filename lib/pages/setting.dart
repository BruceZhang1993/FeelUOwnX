part of pages;

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  AppSettings settings;

  @override
  void initState() {
    super.initState();
    StreamingSharedPreferences.instance.then((prefs) {
      setState(() {
        settings = AppSettings(prefs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 2.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GFListTile(
            title: Text(
              'Daemon IP',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subTitle: Text(
              'The IP of FeelUOwn daemon.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            icon: settings != null ? Text(settings.daemonIp.getValue()) : Text('-'),
          ),
          GFListTile(
            title: Text(
              'Force dark mode',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subTitle: Text(
              'Force enable dark mode.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            icon: GFToggle(
              onChanged: (v) {
                settings.forceDark.setValue(v);
              },
              value: settings != null ? settings.forceDark.getValue() : false,
            ),
          ),
          GestureDetector(
            onTap: () async {
              String docDir = (await getApplicationDocumentsDirectory()).path;
              if (!(await File('$docDir/demo.mp3').exists())) {
              ByteData data = await DefaultAssetBundle.of(context).load('assets/demo/demo.mp3');
              await File('$docDir/demo.mp3').writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
              }
              PlaybackService.startPlay(File('$docDir/demo.mp3').path, isLocal: true).catchError((_) => showSnackBar(context, 'Something wrong.'));
            },
            child: GFListTile(
              title: Text(
                'Audio test',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subTitle: Text(
                'Play a song locally.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
