import 'package:estructura_practica_1/drinks/item_hot_drinks_details.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:estructura_practica_1/models/product_hot_drinks.dart';

class ItemHotDrinks extends StatefulWidget {
  final ProductHotDrinks drink;
  final List<ProductItemCart> carItems;

  ItemHotDrinks({
    Key key,
    @required this.drink,
    @required this.carItems
  }) : super(key: key);

  @override
  _ItemHotDrinksState createState() => _ItemHotDrinksState();
}

class _ItemHotDrinksState extends State<ItemHotDrinks> {
  var _currentColor = [PRIMARY_COLOR, LIKED];

  void openDetails() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HotDrinkDetailsPage(drink: widget.drink, carItems: widget.carItems);
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
                      Text("Café", style: TextStyle(color: Colors.black, fontSize: 22)),
                      Text("${widget.drink.productTitle}", style: TextStyle(color: Colors.white, fontSize: 24)),
                      Text("\$${widget.drink.productPrice.round()}", style: TextStyle(color: Colors.black, fontSize: 30)), 
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
                        image: new NetworkImage(widget.drink.productImage),
                      )
                    )
                  )
                ),
              IconButton(icon: Icon(Icons.favorite, color: _currentColor[ widget.drink.liked ? 1:0]), onPressed: (){
                setState(() {
                  widget.drink.liked = !widget.drink.liked;
                });
              })
            ]
          )
        )
      )
    );
  }
}
