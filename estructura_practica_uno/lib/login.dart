import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';



class Login extends StatelessWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: PRIMARY_COLOR,
        child: ListView(
          // physics: ScrollPhysics(),
          // shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/8),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: width/3, bottom: width/4, left: 15, right: 15),
                    child: Image.asset('assets/cupping.png')
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nombre completo:", style: TextStyle(color: Colors.white)),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0)
                            ),
                            fillColor: Colors.white,
                            filled: true
                          ),
                        ),
                      ]
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password:", style: TextStyle(color: Colors.white)),
                        Theme(
                          data: ThemeData(
                            primaryColor: Colors.white,
                            primaryColorDark: Colors.white,
                          ),
                          child:TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.transparent,
                              filled: true
                            ),
                            obscureText: true,
                          )
                        )
                      ]
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),                
                    child: ButtonTheme(
                      height: 60,
                      minWidth: width - 40,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/home');
                        },
                        child: Text("ENTRAR", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        color: BUTTON_COLOR_A,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.white),)
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Column(
                      children: [
                        Text('¿Aún no tienes cuenta?', style: TextStyle(color: Colors.white)),
                        Padding(
                          padding: EdgeInsets.only(top:5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacementNamed('/register');
                            },
                            child:Text('REGÍSTRATE', style: TextStyle(color: Colors.white, decoration: TextDecoration.underline))
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}