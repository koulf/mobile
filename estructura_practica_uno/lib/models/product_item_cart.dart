import 'package:flutter/foundation.dart';

class ProductItemCart {
  String productTitle;
  String size;
  int productAmount;
  double productPrice;
  String productImage;
  dynamic objectReference;

  ProductItemCart({
    @required this.productTitle,
    @required this.productAmount,
    @required this.productPrice,
    @required this.productImage,
    @required this.size,
    @required this.objectReference
  });
}
