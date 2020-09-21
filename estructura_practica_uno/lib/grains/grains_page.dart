import 'package:estructura_practica_1/cart/cart.dart';
import 'package:estructura_practica_1/grains/item_grains.dart';
import 'package:estructura_practica_1/models/product_grains.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:flutter/material.dart';


class GrainsPage extends StatefulWidget {
  final List<ProductGrains> grainsList;
  final List<ProductItemCart> carItems;
  GrainsPage({
    Key key,
    @required this.grainsList,
    @required this.carItems
  }) : super(key: key);

  @override
  _GrainsPageState createState() => _GrainsPageState();
}

class _GrainsPageState extends State<GrainsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Granos"),
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
        itemCount: widget.grainsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemGrains(
            grains: widget.grainsList[index],
            carItems: widget.carItems
          );
        },
      ),
    );
  }
}
