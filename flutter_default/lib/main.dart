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

    int _counter = 0;

    @override
    Widget build(BuildContext context) {
        var _scaffoldKey = GlobalKey<ScaffoldState>();
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                title: Text('Material App Bar'),
            ),
            body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    FlatButton(
                        onPressed: () {
                            _scaffoldKey.currentState
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                                SnackBar(
                                    content: Text('SnackBar')
                                )
                            );
                        },
                        child: Text('Snackbar'),
                        color: Colors.blue[100],
                    )
                ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                            return AlertDialog(
                                title: Text('Title'),
                                content: Text('Dialog Content'),
                                actions: [
                                    FlatButton(
                                        onPressed: () {
                                            Navigator.of(context).pop();
                                        },
                                        child: Text('Accept')
                                    )
                                ],
                            );
                        }
                    );
                },
                child: Icon(Icons.adjust),
                tooltip: 'Dialog',
            )
        );
    }
}
