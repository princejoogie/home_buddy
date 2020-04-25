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
  var baseUrl = "http://192.168.1.6/home_buddy_crud/images/";

  _ProductDetailState(Product product) {
    _product = product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_product.name),
        backgroundColor: Color(0xFFF0EAEA).withOpacity(0.5),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                height: 250,
                width: double.infinity,
                child: Hero(
                  tag: _product,
                  child: Image.network(
                    baseUrl + _product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  _product.price,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
