import 'package:estructura_practica_1/cart/cart.dart';
import 'package:estructura_practica_1/desserts/item_desserts.dart';
import 'package:estructura_practica_1/models/product_dessert.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:flutter/material.dart';


class DessertsPage extends StatefulWidget {
  final List<ProductDessert> dessertsList;
  final List<ProductItemCart> carItems;
  DessertsPage({
    Key key,
    @required this.dessertsList,
    @required this.carItems
  }) : super(key: key);

  @override
  _DessertsPageState createState() => _DessertsPageState();
}

class _DessertsPageState extends State<DessertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Postres"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Cart(productsList: widget.carItems);
                  }
                )
              );
              setState(() {});
            }
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.dessertsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemDesserts(
            dessert: widget.dessertsList[index],
            carItems: widget.carItems
          );
        },
      ),
    );
  }
}
