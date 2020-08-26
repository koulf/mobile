import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StateFullWidget {
  final _textController = TextEditingController();
  bool _isActive = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
          backgroundColor: Colors.black54,
          actions: [
            IconButton(
              icon: Icon(Icons.done_all),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          children: [
            Text('Mi primer app'),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ingrese texto",
                prefix: Icon(Icons.accessibility_new)
              ),
              maxLength: 12,
            ),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Text('Mostrar'),
                  color: Colors.amber[100]

                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text('Borrar'),
                  color: Colors.deepPurple[100] 
                )
              ],
            ),
            Row(
              children: [
                Text('Dificil'),
                Switch(value: null, onChanged: (newVal){
                  setState((){

                  })
                }),
                Text('Facil')
              ],)
          ]
        ),
      ),
    );
  }
}