import 'package:estructura_practica_1/checkout.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:estructura_practica_1/cart/item_cart.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';

class Cart extends StatefulWidget {
  final List<ProductItemCart> productsList;
  Cart({
    Key key,
    @required this.productsList,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double _total = 0;
  @override
  void initState() {
    super.initState();
    for (var item in widget.productsList) {
      _total += (item.productPrice * item.productAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
        centerTitle: true
      ),
      body: ListView(
        children: [
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.productsList.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemCart(
                onAmountUpdated: _priceUpdate,
                removeHandle: removeProduct,
                product: widget.productsList[index],
                index: index
              );
            }
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total"),
                  Text("\$${_total % 1 == 0 ? _total.round() : _total}", style: TextStyle(fontSize: 24)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: ButtonTheme(
                      height: 60,
                      minWidth: width - 40,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Checkout(carItems: widget.productsList))
                          );
                        },
                        child: Text("PAGAR", style: TextStyle(fontSize: 12)),
                        color: BUTTON_COLOR_A,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        )
                      )
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }

  void _priceUpdate(double newItemPrice) {
    setState(() {
      _total += newItemPrice;
    });
  }

  void removeProduct(int index) {
    setState(() {
      _total -= widget.productsList.elementAt(index).productAmount * widget.productsList.elementAt(index).productPrice;
      widget.productsList.removeAt(index);
    });
  }
}
