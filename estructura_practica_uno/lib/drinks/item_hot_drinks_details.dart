import 'package:estructura_practica_1/models/product_hot_drinks.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';



class HotDrinkDetailsPage extends StatefulWidget {
  final ProductHotDrinks drink;
  final List<ProductItemCart> carItems;
  HotDrinkDetailsPage({
    Key key,
    @required this.drink,
    @required this.carItems
  }) : super(key: key);

  @override
  _HotDrinkDetailsPageState createState() => _HotDrinkDetailsPageState();
}

class _HotDrinkDetailsPageState extends State<HotDrinkDetailsPage> {

  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {

    var _currentColor = [PRIMARY_COLOR, LIKED];
    final double maxWidth = MediaQuery.of(context).size.width;
    final double horPadd = 30.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.productTitle),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR
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
                                image: new NetworkImage(widget.drink.productImage),
                              )
                            )
                          )
                        )
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
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(widget.drink.productTitle, style: TextStyle(fontSize: 28)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(widget.drink.productDescription, style: TextStyle(fontSize: 20)),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("TAMAÑOS DISPONIBLES"),
              Text("\$${widget.drink.productPrice.round()}", style: TextStyle(fontSize: 32))
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
                      widget.drink.productSize = ProductSize.CH;
                      widget.drink.productPrice = widget.drink.productPriceCalculator();
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
                      widget.drink.productSize = ProductSize.M;
                      widget.drink.productPrice = widget.drink.productPriceCalculator();
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
                    widget.drink.productSize = ProductSize.G;
                    widget.drink.productPrice = widget.drink.productPriceCalculator();
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
                      switch (widget.drink.productSize) {
                        case ProductSize.CH:
                          size = "chico";
                          break;
                        case ProductSize.M:
                          size = "mediano";
                          break;
                        case ProductSize.G:
                          size = "grande";
                          break;
                      }
                      int i;
                      for (i = 0; i < widget.carItems.length; i++)
                        if(widget.carItems.elementAt(i).productTitle == widget.drink.productTitle && widget.carItems.elementAt(i).size == size){
                          widget.carItems.elementAt(i).productAmount += 1;
                          break;
                        }
                      if(i == widget.carItems.length)
                        widget.carItems.add(ProductItemCart(
                          productTitle: widget.drink.productTitle, 
                          productAmount: 1,
                          productPrice: widget.drink.productPrice,
                          productImage: widget.drink.productImage,
                          size: size
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
                    onPressed: (){},
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