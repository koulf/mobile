import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:estructura_practica_1/drinks/item_hot_drinks.dart';
import 'package:estructura_practica_1/models/product_hot_drinks.dart';

class HotDrinksPage extends StatefulWidget {
  final List<ProductHotDrinks> drinksList;
  final List<ProductItemCart> carItems;
  HotDrinksPage({
    Key key,
    @required this.drinksList,
    @required this.carItems
  }) : super(key: key);

  @override
  _HotDrinksPageState createState() => _HotDrinksPageState();
}

class _HotDrinksPageState extends State<HotDrinksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bebidas"),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
      ),
      body: ListView.builder(
        itemCount: widget.drinksList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemHotDrinks(
            drink: widget.drinksList[index],
            carItems: widget.carItems
          );
        },
      ),
    );
  }
}
