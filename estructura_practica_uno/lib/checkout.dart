import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';
 


class Checkout extends StatefulWidget {

  final List<ProductItemCart> carItems;

  const Checkout({
    Key key,
    @required this.carItems
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  void goHome(context) {
    if(widget.carItems != null)
      widget.carItems.clear();
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  void doShowDialog(context){
    
    double width = MediaQuery.of(context).size.width;

    showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Image.asset('assets/cd.jpg', width: width - 48),
        titlePadding: EdgeInsets.all(0.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:8), 
                  child: Image.asset('assets/cup.png', width: width/10)
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('¡Orden exitosa!', style: TextStyle(fontSize: 20),),
                    Text('Taza Cupping')
                  ]
                )
              ]
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child:  Text('Tu orden ha sido registrada, para más información busca en la opción historial de compras en tu perfil', maxLines: 2)
            )
          ]
        ),
        actions: [
          FlatButton(
            onPressed: () {
              goHome(context);
            },
            child: Text('Aceptar'))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagos'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Elije tu método de pago:', style: TextStyle(fontSize: 28)),
            GestureDetector(
              onTap: () {
                doShowDialog(context);
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 15),
                elevation: 7.0,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [CARD_COLOR_A, BUTTON_COLOR_A]
                    )
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset('assets/cc.png', width: width/6)
                      ),
                      Container(
                        width: width - width/6 - 48 - 24 - 70 - 10,
                        child: Center(
                          child: Text('Tarjeta de crédito', maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 30)),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.edit)
                      )
                    ]
                  )
                )
              )
            ),
            GestureDetector(
              onTap: () {
                doShowDialog(context);
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 15),
                elevation: 7.0,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [CARD_COLOR_A, BUTTON_COLOR_A]
                    )
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset('assets/pp.png', width: width/6)
                      ),
                      Container(
                        width: width - width/6 - 48 - 24 - 70 - 10,
                        child: Center(
                          child: Text('PayPal', maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 30)),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.edit)
                      )
                    ]
                  )
                )
              )
            ),
            GestureDetector(
              onTap: () {
                doShowDialog(context);
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 15),
                elevation: 7.0,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [CARD_COLOR_A, BUTTON_COLOR_A]
                    )
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset('assets/gc.png', width: width/6)
                      ),
                      Container(
                        width: width - width/6 - 48 - 24 - 70 - 10,
                        child: Center(
                          child: Text('Tarjeta de regalo', maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 30)),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(Icons.edit)
                      )
                    ]
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}