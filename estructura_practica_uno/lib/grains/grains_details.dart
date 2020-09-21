import 'package:estructura_practica_1/checkout.dart';
import 'package:estructura_practica_1/models/product_grains.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';



class GrainsDetailsPage extends StatefulWidget {
  final ProductGrains grains;
  final List<ProductItemCart> carItems;
  GrainsDetailsPage({
    Key key,
    @required this.grains,
    @required this.carItems
  }) : super(key: key);

  @override
  _GrainsDetailsPageState createState() => _GrainsDetailsPageState();
}

class _GrainsDetailsPageState extends State<GrainsDetailsPage> {

  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    
    switch(widget.grains.productWeight){
      case ProductWeight.CUARTO:
        selectedSize = 0;
        break;
      case ProductWeight.KILO:
        selectedSize = 1;
        break;

    };

    var _currentColor = [PRIMARY_COLOR, LIKED];
    final double maxWidth = MediaQuery.of(context).size.width;
    final double horPadd = 30.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.grains.productTitle),
        centerTitle: true
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 60.0, left: horPadd, right: horPadd, bottom: 10),
        children: <Widget>[
          Container(
            height: maxWidth - 2 * horPadd,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [CARD_COLOR_B, CARD_COLOR_B2]
              )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: maxWidth - 2 * horPadd,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(30),
                        width: maxWidth - 4*horPadd,
                        height: maxWidth - 4*horPadd,
                        child: AspectRatio(
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
                        )
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
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(widget.grains.productTitle, style: TextStyle(fontSize: 28)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(widget.grains.productDescription, style: TextStyle(fontSize: 20)),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("TAMAÑOS DISPONIBLES"),
              Text("\$${widget.grains.productPrice.round()}", style: TextStyle(fontSize: 32))
            ]
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  label: Text("Cuarto"),
                  selected: this.selectedSize == 0,
                  onSelected: (bool selected) {
                    setState((){
                      this.selectedSize = selected ? 0 : null;
                      widget.grains.productWeight = ProductWeight.CUARTO;
                      widget.grains.productPrice = widget.grains.productPriceCalculator();
                    }
                    );
                  }
                )
              ),
              ChoiceChip(
                label: Text("Kilo"),
                selected: this.selectedSize == 1,
                onSelected: (bool selected) {
                  setState((){
                    this.selectedSize = selected ? 2 : null;
                    widget.grains.productWeight = ProductWeight.KILO;
                    widget.grains.productPrice = widget.grains.productPriceCalculator();
                  }
                  );
                }
              )
            ]
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonTheme(
                  height: 60,
                  child: FlatButton(
                    onPressed: (){
                      String size;
                      switch (widget.grains.productWeight) {
                        case ProductWeight.CUARTO:
                          size = "cuarto";
                          break;
                        case ProductWeight.KILO:
                          size = "kilo";
                          break;
                      }
                      int i;
                      for (i = 0; i < widget.carItems.length; i++)
                        if(widget.carItems.elementAt(i).productTitle == widget.grains.productTitle && widget.carItems.elementAt(i).size == size){
                          widget.carItems.elementAt(i).productAmount += 1;
                          break;
                        }
                      if(i == widget.carItems.length)
                        widget.carItems.add(ProductItemCart(
                          productTitle: widget.grains.productTitle, 
                          productAmount: 1,
                          productPrice: widget.grains.productPrice,
                          productImage: widget.grains.productImage,
                          size: size,
                          objectReference: widget.grains
                        ));
                      Navigator.of(context).pop();
                    },
                    child: Text("AGREGAR AL CARRITO", style: TextStyle(color: Colors.white, fontSize: 12),),
                    color: BUTTON_COLOR_A,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
                ButtonTheme(
                  height: 60,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return Checkout(carItems: null);
                        })
                      );
                    },
                    child: Text("COMPRAR AHORA", style: TextStyle(color: Colors.white, fontSize: 12)),
                    color: BUTTON_COLOR_A,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    )
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}