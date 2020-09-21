import 'package:estructura_practica_1/checkout.dart';
import 'package:estructura_practica_1/models/product_dessert.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';



class DessertDetailsPage extends StatefulWidget {
  final ProductDessert dessert;
  final List<ProductItemCart> carItems;
  DessertDetailsPage({
    Key key,
    @required this.dessert,
    @required this.carItems
  }) : super(key: key);

  @override
  _DessertDetailsPageState createState() => _DessertDetailsPageState();
}

class _DessertDetailsPageState extends State<DessertDetailsPage> {

  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    
    switch(widget.dessert.productSize){
      case DessertSize.CH:
        selectedSize = 0;
        break;
      case DessertSize.M:
        selectedSize = 1;
        break;
      case DessertSize.G:
        selectedSize = 2;
        break;
    };

    var _currentColor = [PRIMARY_COLOR, LIKED];
    final double maxWidth = MediaQuery.of(context).size.width;
    final double horPadd = 30.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dessert.productTitle),
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
                                image: new NetworkImage(widget.dessert.productImage),
                              )
                            )
                          )
                        )
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
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(widget.dessert.productTitle, style: TextStyle(fontSize: 28)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(widget.dessert.productDescription, style: TextStyle(fontSize: 20)),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("TAMAÑOS DISPONIBLES"),
              Text("\$${widget.dessert.productPrice.round()}", style: TextStyle(fontSize: 32))
            ]
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  label: Text("Chico"),
                  selected: this.selectedSize == 0,
                  onSelected: (bool selected) {
                    setState((){
                      this.selectedSize = selected ? 0 : null;
                      widget.dessert.productSize = DessertSize.CH;
                      widget.dessert.productPrice = widget.dessert.productPriceCalculator();
                    }
                    );
                  }
                )
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  label: Text("Mediano"),
                  selected: this.selectedSize == 1,
                  onSelected: (bool selected) {
                    setState((){
                      this.selectedSize = selected ? 1 : null;
                      widget.dessert.productSize = DessertSize.M;
                      widget.dessert.productPrice = widget.dessert.productPriceCalculator();
                    }
                    );
                  }
                )
              ),
              ChoiceChip(
                label: Text("Grande"),
                selected: this.selectedSize == 2,
                onSelected: (bool selected) {
                  setState((){
                    this.selectedSize = selected ? 2 : null;
                    widget.dessert.productSize = DessertSize.G;
                    widget.dessert.productPrice = widget.dessert.productPriceCalculator();
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
                      switch (widget.dessert.productSize) {
                        case DessertSize.CH:
                          size = "chico";
                          break;
                        case DessertSize.M:
                          size = "mediano";
                          break;
                        case DessertSize.G:
                          size = "grande";
                          break;
                      }
                      int i;
                      for (i = 0; i < widget.carItems.length; i++)
                        if(widget.carItems.elementAt(i).productTitle == widget.dessert.productTitle && widget.carItems.elementAt(i).size == size){
                          widget.carItems.elementAt(i).productAmount += 1;
                          break;
                        }
                      if(i == widget.carItems.length)
                        widget.carItems.add(ProductItemCart(
                          productTitle: widget.dessert.productTitle, 
                          productAmount: 1,
                          productPrice: widget.dessert.productPrice,
                          productImage: widget.dessert.productImage,
                          size: size,
                          objectReference: widget.dessert
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