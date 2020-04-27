import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_buddy/models/cart_item_model.dart';
import 'package:http/http.dart' as http;

class CartTab extends StatefulWidget {
  String email;
  CartTab({this.email});

  @override
  _CartTabState createState() => _CartTabState(email);
}

class _CartTabState extends State<CartTab> {
  var baseUrl = "http://192.168.1.4/home_buddy_crud/images/";
  var totalPrice = 0;
  String email;

  _CartTabState(this.email);

  Future<void> _removeItem(int index) async {
    final response = await http.post(
      'http://192.168.1.4/home_buddy_crud/api/remove_from_cart.php',
      body: {'email': email, 'index': index.toString()},
    );

    print(response.body);

    setState(() {});
  }

  Future<List<CartItem>> _fetchCartItems() async {
    final response = await http.post(
      'http://192.168.1.4/home_buddy_crud/api/get_cart.php',
      body: {'email': email},
    );

    var data = json.decode(response.body);

    List<CartItem> items = [];

    for (var i in data) {
      CartItem product = CartItem.fromJson(i);
      items.add(product);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 5,
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: 100,
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
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF808080)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '₱' + totalPrice.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Color(0xFF007BFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Checkout',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      radius: 25,
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.refresh,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "CART",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      radius: 25,
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 55,
          bottom: 110,
          right: 0,
          left: 0,
          child: FutureBuilder(
            future: _fetchCartItems(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(child: Text("Loading...")),
                );
              } else {
                // return Container(
                //   child: Center(child: Text('Loaded.')),
                // );
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    CartItem item = snapshot.data[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    height: 100,
                                    child: Image.network(
                                      baseUrl + item.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        item.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text('x' +
                                          item.quantity.toString() +
                                          " | " +
                                          item.type),
                                    ],
                                  ),
                                ),
                                Expanded(flex: 1, child: Container()),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  radius: 10,
                                  onTap: () {
                                    _removeItem(index);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20,
                                    height: 20,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '₱' + item.totalPrice.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF808080)),
                              ),
                            ),
                          ),
                        ],
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
