import 'package:flutter/material.dart';
import 'package:home_buddy/screens/payment/confirm_order.dart';

class CashOnDeliveryScreen extends StatefulWidget {
  final totalPrice, totalItems, email, deliveryFee, items;
  CashOnDeliveryScreen(
      {this.totalPrice, this.totalItems, this.email, this.deliveryFee, this.items});
  @override
  _CashOnDeliveryScreenState createState() => _CashOnDeliveryScreenState();
}

class _CashOnDeliveryScreenState extends State<CashOnDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String _fullName = "",
      _phoneNumber = "",
      _address = "",
      _message = "",
      error = "";

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
          "Cash On Delivery",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'Full Name is required' : null,
                    onChanged: (val) {
                      setState(() {
                        _fullName = val.trim();
                        error = "";
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                      border: OutlineInputBorder(),
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Full Name',
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (val) =>
                        val.isEmpty ? 'Phone Number is required' : null,
                    onChanged: (val) {
                      setState(() {
                        _phoneNumber = val.trim();
                        error = "";
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: Colors.grey),
                      border: OutlineInputBorder(),
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text('  Detailed Address'),
                  SizedBox(height: 5.0),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'Address is required' : null,
                    onChanged: (val) {
                      setState(() {
                        _address = val.trim();
                        error = "";
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home, color: Colors.grey),
                      border: OutlineInputBorder(),
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      labelText:
                          'Unit number, house number, building, street name',
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        _message = val.trim();
                        error = "";
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.text_fields, color: Colors.grey),
                      border: OutlineInputBorder(),
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      labelText: 'Additional Message',
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    elevation: 1.0,
                    color: Colors.blue,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(widget.totalPrice);
                        print(widget.totalItems);
                        print(_address);
                        print(_phoneNumber);
                        print(_fullName);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ConfirmOrder(
                              totalPrice: widget.totalPrice,
                              totalItems: widget.totalItems,
                              address: _address,
                              phoneNumber: _phoneNumber,
                              name: _fullName,
                              email: widget.email,
                              message: _message,
                              deliveryFee: widget.deliveryFee,
                              items: widget.items,
                            ),
                          ),
                        );
                      }
                    },
                    child: loading
                        ? CircularProgressIndicator()
                        : Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
