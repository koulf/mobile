import 'package:estructura_practica_1/cart/cart.dart';
import 'package:estructura_practica_1/desserts/desserts_page.dart';
import 'package:estructura_practica_1/drinks/hot_drinks_page.dart';
import 'package:estructura_practica_1/grains/grains_page.dart';
import 'package:estructura_practica_1/models/product_dessert.dart';
import 'package:estructura_practica_1/models/product_grains.dart';
import 'package:estructura_practica_1/models/product_hot_drinks.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/models/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:estructura_practica_1/home/item_home.dart';
import 'package:estructura_practica_1/profile.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<ProductHotDrinks> drinks;
  List<ProductGrains> grains;
  List<ProductDessert> desserts;
  List<ProductItemCart> carItems = List<ProductItemCart>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Profile()
      ),
      appBar: AppBar(
        title: Text(widget.title, textAlign: TextAlign.center,),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Cart(productsList: this.carItems);
                  }
                )
              );
            }
          )
        ]
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: _openHotDrinksPage,
            child: ItemHome(
              title: "Bebidas calientes",
              image: "https://i.imgur.com/XJ0y9qs.png",
            ),
          ),
          GestureDetector(
            onTap: _openGrainsPage,
            child: ItemHome(
              title: "Granos",
              image: "https://i.imgur.com/5MZocC1.png",
            )
          ),
          GestureDetector(
            onTap: _openDessertPage,
            child: ItemHome(
              title: "Postres",
              image: "https://i.imgur.com/fI7Tezv.png",
            )
          ),
          GestureDetector(
            onTap: showSnackBar,
            child: ItemHome(
              title: "Tazas",
              image: "https://i.imgur.com/fMjtSpy.png"
            )
          ),
        ],
      ),
    );
  }

  void showSnackBar() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('Próximamente'),
        action: SnackBarAction(
          label: 'close',
          onPressed:() => _scaffoldKey.currentState.hideCurrentSnackBar()
        )));
  }

  void _openHotDrinksPage() {
    // DONE: completar en navigator pasando los parametros a la pagina de HotDrinksPage

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if(this.drinks == null)
            this.drinks = ProductRepository.loadProducts(ProductType.BEBIDAS);
          return HotDrinksPage(drinksList: this.drinks, carItems: this.carItems);
        },
      ),
    );
  }

  void _openGrainsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if(this.grains == null)
            this.grains = ProductRepository.loadProducts(ProductType.GRANO);
          return GrainsPage(grainsList: this.grains, carItems: this.carItems);
        },
      ),
    );
  }

  void _openDessertPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if(this.desserts == null)
            this.desserts = ProductRepository.loadProducts(ProductType.POSTRES);
          return DessertsPage(dessertsList: this.desserts, carItems: this.carItems);
        },
      ),
    );
  }
}
