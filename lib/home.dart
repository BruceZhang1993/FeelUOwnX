import 'services/fuo_runner.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'pages/pages.dart' as pages;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
