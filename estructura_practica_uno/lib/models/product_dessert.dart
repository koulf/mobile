// DONE: Crear producto "ProductCup" siguiendo la logica de Drinks y Grains
// TODO: Agregar al ProductRepository una lista de estos productos.

import 'dart:math';
import 'package:flutter/foundation.dart';

enum ProductSize { CH, M, G }

class ProductDesert {
  final String productTitle; // nombre del producto
  final String productDescription; // descripcion del producto
  final String productImage; // url de imagen del producto
  ProductSize productSize; // tamano del producto
  double productPrice; // precio del producto autocalculado
  final int productAmount; // cantidad de producto por comprar
  bool liked;

  ProductDesert({
    @required this.productTitle,
    @required this.productDescription,
    @required this.productImage,
    @required this.productSize,
    @required this.productAmount,
    this.liked = false,
  }) {
    // inicializa el precio de acuerdo a la size del producto
    productPrice = productPriceCalculator();
  }

  double productPriceCalculator() {
    if (this.productSize == ProductSize.CH)
      return (20 + Random().nextInt(40)).toDouble();
    if (this.productSize == ProductSize.M)
      return (40 + Random().nextInt(60)).toDouble();
    if (this.productSize == ProductSize.G)
      return (60 + Random().nextInt(80)).toDouble();
    return 999.0;
  }
}
