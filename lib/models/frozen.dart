import 'package:flutter/material.dart';
import 'package:home_buddy/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Frozen extends StatefulWidget {
  @override
  _FrozenState createState() => _FrozenState();
}

class _FrozenState extends State<Frozen> {
  var baseUrl = "http://192.168.1.6/home_buddy_crud/images/";

  Future<List<Product>> _fetchProducts() async {
    final response = await http.get(
      'http://192.168.1.6/home_buddy_crud/api/get_category.php?category=Frozen',
    );

    var data = json.decode(response.body);

    List<Product> products = [];

    for (var p in data) {
      Product product = Product.fromJson(p);
      products.add(product);
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frozen",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF534747),
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 14.0,
                  letterSpacing: 1.0,
                  color: Color(0xFF534747),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 290,
          child: FutureBuilder(
            future: _fetchProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading...")));
              } else {
                return ListView.builder(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = snapshot.data[index];

                    var finalPrice = "";
                    var data = json.decode(product.price);
                    var keys = data.keys.toList();
                    for (var key in keys) {
                      finalPrice += (key + ": " + data[key].toString() + " ");
                    }

                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        width: 250.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFffecc7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 200,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Image.network(
                                        baseUrl + product.imageUrl,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFFffecc7).withOpacity(0.7),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        product.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    finalPrice,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(product.category),
                                  Text("Stock: " + product.stock),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
