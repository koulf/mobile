import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentColor = [Colors.white, Colors.red[900]];
  int _index = 0;
  int _clicksCounter = 0;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _snackbars = [
      SnackBar(
          content: Text('Odd'),
          action: SnackBarAction(
              label: 'action',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('Datetime'),
                        content: Text('${DateTime.now()}'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Exit'))
                        ],
                      );
                    });
              })),
      SnackBar(content: Text('Even')),
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Click the FAB'),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite, color: _currentColor[_index]),
              onPressed: () {
                _scaffoldKey.currentState
                  ..hideCurrentSnackBar()
                  ..showSnackBar(_snackbars[_index]);
                setState(() {
                  _clicksCounter++;
                  _index = (_index + 1) % 2;
                });
              })
        ],
      ),
      body: Center(
        child: Container(
          child: Text('Clicks: $_clicksCounter'),
        ),
      ),
    );
  }
}
