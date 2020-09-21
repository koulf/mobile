import 'package:estructura_practica_1/desserts/item_desserts_details.dart';
import 'package:estructura_practica_1/models/product_dessert.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemDesserts extends StatefulWidget {
  final ProductDessert dessert;
  final List<ProductItemCart> carItems;

  ItemDesserts({
    Key key,
    @required this.dessert,
    @required this.carItems
  }) : super(key: key);

  @override
  _ItemDessertsState createState() => _ItemDessertsState();
}

class _ItemDessertsState extends State<ItemDesserts> {
  var _currentColor = [PRIMARY_COLOR, LIKED];

  void openDetails() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DessertDetailsPage(dessert: widget.dessert, carItems: widget.carItems);
        },
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openDetails,
      child: Container(
        height: 220,
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.all(24.0),
          color: CARD_COLOR_A,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Postre", style: TextStyle(color: Colors.black, fontSize: 22)),
                      Text("${widget.dessert.productTitle}", style: TextStyle(color: Colors.white, fontSize: 24)),
                      Text("\$${widget.dessert.productPrice.round()}", style: TextStyle(color: Colors.black, fontSize: 30)), 
                    ]
                  )
                ) 
              ),
              AspectRatio(
                  aspectRatio: 4/5,
                  child: new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        fit: BoxFit.fitHeight,
                        alignment: FractionalOffset.topCenter,
                        image: new NetworkImage(widget.dessert.productImage),
                      )
                    )
                  )
                ),
              IconButton(icon: Icon(Icons.favorite, color: _currentColor[ widget.dessert.liked ? 1:0]), onPressed: (){
                setState(() {
                  widget.dessert.liked = !widget.dessert.liked;
                });
              })
            ]
          )
        )
      )
    );
  }
}
