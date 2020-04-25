import 'package:flutter/material.dart';
import 'package:home_buddy/models/product_model.dart';

class ProductDetail extends StatefulWidget {
  Product _product;
  ProductDetail(Product product) {
    _product = product;
  }

  @override
  _ProductDetailState createState() => _ProductDetailState(_product);
}

class _ProductDetailState extends State<ProductDetail> {
  Product _product;

  _ProductDetailState(Product product) {
    _product = product;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
