import 'package:estructura_practica_1/cart/cart.dart';
import 'package:estructura_practica_1/drinks/hot_drinks_page.dart';
import 'package:estructura_practica_1/models/product_hot_drinks.dart';
import 'package:estructura_practica_1/models/product_item_cart.dart';
import 'package:estructura_practica_1/models/product_repository.dart';
import 'package:estructura_practica_1/utils/constants.dart';
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
  List<ProductItemCart> carItems = List<ProductItemCart>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, textAlign: TextAlign.center,),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                // TODO: Eliminar este boton y adaptar todo el contenido de la pagina de perfil en un Drawer aqui en la pantalla Home
                MaterialPageRoute(builder: (_) => Profile()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              var x = await Navigator.of(context).push(
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
          ItemHome(
            title: "Granos",
            image: "https://i.imgur.com/5MZocC1.png",
          ),
          ItemHome(
            title: "Postres",
            image: "https://i.imgur.com/fI7Tezv.png",
          ),
          ItemHome(
            // TODO: Al hacer clic, que muestre un snackbar de "Proximamente"
            title: "Tazas",
            image: "https://i.imgur.com/fMjtSpy.png",
          ),
        ],
      ),
    );
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
      MaterialPageRoute(builder: (context) => null),
    );
  }

  void _openDessertPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => null),
    );
  }
}
