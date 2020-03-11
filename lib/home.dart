import 'dart:io';

import 'package:FeelUOwnX/services/fuo_runner.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
      ),
      drawer: GFDrawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GFDrawerHeader(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'FeelUOwn X',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
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
                        FuoRunner.runDaemon().catchError((err) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Something wrong happened when starting FeelUOwn: ' + err.toString()),
                          ));
                        });
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
      body: Container(),
    );
  }
}
