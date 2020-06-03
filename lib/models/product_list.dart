import 'package:flutter/material.dart';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/models/product_model.dart';
import 'package:home_buddy/screens/product_detail.dart';
import 'package:home_buddy/screens/see_all.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductList extends StatefulWidget {
  final String url, title, email;
  final Color color;

  ProductList({this.url, this.title, this.color, this.email});

  @override
  _ProductListState createState() =>
      _ProductListState(url, title, color, email);
}

class _ProductListState extends State<ProductList> {
  String url, title, email;
  Color color;
  _ProductListState(this.url, this.title, this.color, this.email);

  Future<List<Product>> _fetchProducts() async {
    
    final response = await http.get(url);

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
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF534747),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SeeAllScreen(
                        title: title,
                        color: color,
                        email: email,
                      ),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 1.0,
                    color: Color(0xFF007BFF),
                  ),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                              product: product,
                              email: email,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: 250.0,
                          height: 250.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 270,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Hero(
                                    tag: product,
                                    child: Image.network(
                                      baseUrl + product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                    color: color,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          product.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "3.5",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFFF2F2F2),
                                              ),
                                            ),
                                            Icon(Icons.star,
                                                size: 16, color: Colors.yellow),
                                            Icon(Icons.star,
                                                size: 16, color: Colors.yellow),
                                            Icon(Icons.star,
                                                size: 16, color: Colors.yellow),
                                            Icon(Icons.star_half,
                                                size: 16, color: Colors.yellow),
                                            Icon(Icons.star_border,
                                                size: 16, color: Colors.yellow),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
