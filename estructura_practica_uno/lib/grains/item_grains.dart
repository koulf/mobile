import 'package:estructura_practica_1/grains/grains_details.dart';
import 'package:estructura_practica_1/models/product_grains.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';


class ItemGrains extends StatefulWidget {
  final ProductGrains grains;
  final List<ProductItemCart> carItems;

  ItemGrains({
    Key key,
    @required this.grains,
    @required this.carItems
  }) : super(key: key);

  @override
  _ItemGrainsState createState() => _ItemGrainsState();
}

class _ItemGrainsState extends State<ItemGrains> {
  var _currentColor = [PRIMARY_COLOR, LIKED];

  void openDetails() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return GrainsDetailsPage(grains: widget.grains, carItems: widget.carItems);
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
                      Text("Granos", style: TextStyle(color: Colors.black, fontSize: 22)),
                      Text("${widget.grains.productTitle}", style: TextStyle(color: Colors.white, fontSize: 24)),
                      Text("\$${widget.grains.productPrice.round()}", style: TextStyle(color: Colors.black, fontSize: 30)), 
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
                        image: new NetworkImage(widget.grains.productImage),
                      )
                    )
                  )
                ),
              IconButton(icon: Icon(Icons.favorite, color: _currentColor[ widget.grains.liked ? 1:0]), onPressed: (){
                setState(() {
                  widget.grains.liked = !widget.grains.liked;
                });
              })
            ]
          )
        )
      )
    );
  }
}
