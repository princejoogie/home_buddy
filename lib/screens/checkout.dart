import 'package:flutter/material.dart';
import 'package:home_buddy/screens/payment/cod.dart';
import 'package:home_buddy/screens/payment/gcash.dart';

class CheckoutScreen extends StatefulWidget {
  final totalPrice, totalItems, email, deliveryFee;
  CheckoutScreen(
      {this.totalPrice, this.totalItems, this.email, this.deliveryFee});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Choose Payment Method",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              splashColor: Colors.blueAccent[100],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GcashScreen(
                      totalPrice: widget.totalPrice,
                      totalItems: widget.totalItems,
                      email: widget.email,
                      deliveryFee: widget.deliveryFee,
                    ),
                  ),
                );
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Text('G-Cash', style: TextStyle(fontSize: 24))),
                    SizedBox(height: 10),
                    Container(
                      height: 130,
                      child: Image.asset('assets/gcash.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              splashColor: Colors.blueAccent[100],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CashOnDeliveryScreen(
                      totalPrice: widget.totalPrice,
                      totalItems: widget.totalItems,
                      email: widget.email,
                      deliveryFee: widget.deliveryFee,
                    ),
                  ),
                );
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Text('Cash on Delivery',
                            style: TextStyle(fontSize: 24))),
                    SizedBox(height: 10),
                    Container(
                      height: 150,
                      child: Image.asset('assets/cod.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
