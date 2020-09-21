import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemCart extends StatefulWidget {
  final ProductItemCart product;
  final ValueChanged<double> onAmountUpdated;
  final ValueChanged<int> removeHandle;
  final int index;
  ItemCart({
    Key key,
    @required this.onAmountUpdated,
    @required this.removeHandle,
    @required this.product,
    @required this.index
  }) : super(key: key);

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {

  var _currentColor = [PRIMARY_COLOR, LIKED];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(24),
      elevation: 4.0,
      shadowColor: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [CARD_COLOR_B, CARD_COLOR_B2]
          )
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Image.network(widget.product.productImage)
                )
              )
            ),
            Expanded(
              flex:2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.product.productTitle}", style: TextStyle(fontSize: 22)),
                      IconButton(icon: Icon(Icons.favorite), color: _currentColor[ widget.product.objectReference.liked ? 1:0], onPressed: (){
                        setState(() {
                          widget.product.objectReference.liked = !widget.product.objectReference.liked;
                        });
                      })
                    ]
                  ),
                  Row(
                    children: [
                      Text("Tamaño: ${widget.product.size}",style: TextStyle(color: Colors.white, fontSize: 18))
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.add_circle_outline), onPressed: _addProd),
                      Text("${widget.product. productAmount}", style: TextStyle(fontSize: 22)),
                      IconButton(icon: Icon(Icons.remove_circle), onPressed: _remProd),
                      Text("\$${widget.product.productPrice % 1 == 0 ? widget.product.productPrice.round() : widget.product.productPrice }", style: TextStyle(fontSize: 26)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () {widget.removeHandle(widget.index);})
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  void _addProd() {
    setState(() {
      ++widget.product.productAmount;
    });
    widget.onAmountUpdated(widget.product.productPrice);
  }

  void _remProd() {
    if(widget.product.productAmount > 1) {
      setState(() {
        --widget.product.productAmount;
      });
      widget.onAmountUpdated(-1 * widget.product.productPrice);
    }
  }
}
