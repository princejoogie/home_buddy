import 'dart:convert';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/screens/product_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy/models/product_model.dart';

class SeeAllScreen extends StatefulWidget {
  final String title, email, name;
  final Color color;

  SeeAllScreen({this.title, this.color, this.email, this.name});
  @override
  _SeeAllScreenState createState() =>
      _SeeAllScreenState(this.title, this.color, this.email, this.name);
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  String title, email, name;
  Color color;
  bool noResult = false;
  int num = 0;

  _SeeAllScreenState(this.title, this.color, this.email, this.name);

  Future<List<Product>> _fetchProducts() async {
    final response = title != null
        ? await http.get(getByCategoryAPI + this.title)
        : await http.get(searchAPI + this.name);

    if (response.body == 'empty') {
      noResult = true;
      return null;
    } else {
      var data = json.decode(response.body);
      List<Product> products = [];

      for (var p in data) {
        Product product = Product.fromJson(p);
        products.add(product);
      }

      if (!mounted) return null;
      setState(() {
        num = products.length;
      });

      return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  child: Row(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          radius: 25,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      title != null
                          ? Text(
                              title.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            )
                          : Text(
                              num.toString() +
                                  ' Results for ' +
                                  name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              bottom: 10,
              right: 0,
              left: 0,
              child: FutureBuilder(
                future: _fetchProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (noResult == true) {
                    return Container(
                      child: Center(child: Text("No Results...")),
                    );
                  } else if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFF007BFF),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        Product product = snapshot.data[index];

                        return GestureDetector(
                          child: Padding(
                            padding: index % 2 == 0
                                ? EdgeInsets.fromLTRB(10, 10, 5, 0)
                                : EdgeInsets.fromLTRB(5, 10, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
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
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    top: (MediaQuery.of(context).size.width /
                                                2) /
                                            2 +
                                        20,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      color: color,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            product.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
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
                                                  size: 16,
                                                  color: Colors.yellow),
                                              Icon(Icons.star,
                                                  size: 16,
                                                  color: Colors.yellow),
                                              Icon(Icons.star,
                                                  size: 16,
                                                  color: Colors.yellow),
                                              Icon(Icons.star_half,
                                                  size: 16,
                                                  color: Colors.yellow),
                                              Icon(Icons.star_border,
                                                  size: 16,
                                                  color: Colors.yellow),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
