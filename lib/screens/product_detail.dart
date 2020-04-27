import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:home_buddy/models/product_model.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  String email;
  ProductDetail({this.product, this.email});

  @override
  _ProductDetailState createState() => _ProductDetailState(product, email);
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  String email;
  var baseUrl = "http://192.168.1.4/home_buddy_crud/images/";
  var finalPrice = "";

  _ProductDetailState(this.product, this.email) {
    var data = json.decode(product.price);
    var keys = data.keys.toList();
    for (var key in keys) {
      finalPrice += (key + ": ₱" + data[key].toString() + "\n");
    }
  }

  Future<void> _addToCart(context) async {
    final response = await http.post(
      'http://192.168.1.4/home_buddy_crud/api/add_to_cart.php',
      body: {
        'email': email,
        'id': product.id.toString(),
        'name': product.name,
        'price': product.price.toString(),
        'totalPrice': '1234',
        'quantity': '3',
        'type': 'Per-Pack',
        'imageUrl': product.imageUrl,
      },
    );

    print(response.body);
    if (response.body == 'success') {
      final snackBar =
          SnackBar(content: Text('Added ' + product.name + ' to Cart'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text('Error adding to Cart'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 400,
                  width: double.infinity,
                  child: Hero(
                    tag: product,
                    child: Image.network(
                      baseUrl + product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            finalPrice.trim(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF002CB8),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Text("3.5", style: TextStyle(fontSize: 20)),
                              Icon(Icons.star),
                              Icon(Icons.star),
                              Icon(Icons.star),
                              Icon(Icons.star_half),
                              Icon(Icons.star_border),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Description:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF002CB8),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 140),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              elevation: 2.0,
              fillColor: Colors.white.withOpacity(0.5),
              child: Icon(
                Icons.arrow_back,
                size: 40,
                color: Color(0xFF002CB8),
              ),
              shape: CircleBorder(),
              padding: EdgeInsets.all(5.0),
              splashColor: Color(0xFF6FBAF7),
            ),
          ),
          Positioned(
            bottom: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      color: Color(0xFF007BFF),
                      child: IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        color: Color(0xFFF2F2F2),
                        child: Text(
                          "0",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      color: Color(0xFF007BFF),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) => RaisedButton(
                    onPressed: () {
                      _addToCart(context);
                    },
                    color: Color(0xFF007BFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart, color: Color(0xFF6FBAF7)),
                        SizedBox(width: 10),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
