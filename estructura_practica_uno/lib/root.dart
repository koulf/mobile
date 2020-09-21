import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';



class Root extends StatelessWidget {
  const Root({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: PRIMARY_COLOR,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: width/3, horizontal: width/8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: width/3, left: 15, right: 15),
                child: Image.asset('assets/cupping.png')
              ),
              ButtonTheme(
                height: 60,
                minWidth: width - 40,
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Text("REGÍSTRATE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  color: BUTTON_COLOR_A,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  )
                )
              ),
              ButtonTheme(
                height: 60,
                minWidth: width - 40,
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: Text("INGRESA", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  color: BUTTON_COLOR_A,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}