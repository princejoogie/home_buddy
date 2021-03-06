import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/models/cart_item_model.dart';
import 'package:http/http.dart' as http;

class ConfirmOrderGcash extends StatefulWidget {
  final totalPrice,
      totalItems,
      address,
      phoneNumber,
      name,
      referenceNumber,
      email,
      message,
      deliveryFee,
      items;
  ConfirmOrderGcash({
    this.totalPrice,
    this.totalItems,
    this.address,
    this.phoneNumber,
    this.name,
    this.referenceNumber,
    this.email,
    this.message,
    this.deliveryFee,
    this.items,
  });
  @override
  ConfirmOrderGcashState createState() => ConfirmOrderGcashState();
}

class ConfirmOrderGcashState extends State<ConfirmOrderGcash> {
  bool loading = false;
  Future<String> addDelivery() async {
    final response = await http.post(
      getCartAPI,
      body: {'email': widget.email},
    );

    var items = response.body;

    var addDeliveryResponse = await http.post(
      addDeliveryAPI,
      body: {
        'user_email': widget.email,
        'status': 'PROCESSING',
        'full_name': widget.name,
        'phone_number': widget.phoneNumber,
        'address': widget.address,
        'is_gcash': 'true',
        'gcash_reference_number': widget.referenceNumber,
        'items': items,
        'message': widget.message,
        'delivery_fee': widget.deliveryFee.toString(),
        'total_price': widget.totalPrice.toString(),
      },
    );

    if (addDeliveryResponse.body == 'success') {
      await http.post(clearCartAPI, body: {'email': widget.email});
      return 'Your order is now being processed.';
    } else {
      return addDeliveryResponse.body;
    }
  }

  Future<void> removeStocks() async {
    for (CartItem item in widget.items) {
      final response = await http.post(
        getStockAPI,
        body: {'id': item.id.toString()},
      );
      var currentStock = int.parse(response.body);
      await http.post(
        removeStockAPI,
        body: {
          'id': item.id.toString(),
          'stock': (currentStock - item.quantity).toString(),
        },
      );
    }
  }

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
          "Confirm Details",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Key',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Value',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Full Name')),
                    DataCell(Text(widget.name)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Phone Number')),
                    DataCell(Text(widget.phoneNumber)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('G-Cash Reference Number')),
                    DataCell(Text(widget.referenceNumber)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Address')),
                    DataCell(Text(widget.address)),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Total Items')),
                    DataCell(Text(widget.totalItems.toString())),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Delivery Fee')),
                    DataCell(Text('₱' + widget.deliveryFee.toString())),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Total Price + Delivery Fee')),
                    DataCell(Text('₱' +
                        (int.parse(widget.totalPrice.toString()) +
                                int.parse(widget.deliveryFee.toString()))
                            .toString())),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Additional Message')),
                    DataCell(Text(widget.message.toString())),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                elevation: 1.0,
                color: Colors.blue,
                onPressed: loading
                    ? null
                    : () async {
                        setState(() => loading = true);
                        await removeStocks();
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          child: new CupertinoAlertDialog(
                            title: new Column(
                              children: <Widget>[
                                Text("Message"),
                                SizedBox(height: 10),
                              ],
                            ),
                            content: Text(await addDelivery()),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.popUntil(context,
                                      (Route<dynamic> route) => route.isFirst);
                                },
                                child: new Text("OK"),
                              )
                            ],
                          ),
                        );
                      },
                child: Text('Confirm', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
