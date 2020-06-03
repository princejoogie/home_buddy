import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/models/alert_model.dart';
import 'package:home_buddy/models/cart_item_model.dart';
import 'package:http/http.dart' as http;

class AlertDetail extends StatefulWidget {
  final AlertItem alertItem;

  AlertDetail(this.alertItem);
  @override
  _AlertDetailState createState() => _AlertDetailState();
}

class _AlertDetailState extends State<AlertDetail> {
  List<CartItem> items = [];
  bool deleting = false;

  @override
  void initState() {
    super.initState();
    var data = json.decode(widget.alertItem.items);
    for (var i in data) {
      CartItem product = CartItem.fromJson(i);
      items.add(product);
    }
  }

  Future deleteOrder() async {
    await http.post(
      deleteOrderAPI,
      body: {'id': widget.alertItem.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Order Details', style: TextStyle(fontSize: 16)),
              ),
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
                      DataCell(Text(widget.alertItem.fullName)),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Phone Number')),
                      DataCell(Text(widget.alertItem.phoneNumber)),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Address')),
                      DataCell(Text(widget.alertItem.address)),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Status')),
                      DataCell(Text(widget.alertItem.status)),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Payment')),
                      DataCell(Text(widget.alertItem.isGcash == 'true'
                          ? 'GCash'
                          : 'Cash on Delivery')),
                    ],
                  ),
                  if (widget.alertItem.isGcash == 'true')
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('GCash Ref. Number')),
                        DataCell(Text(widget.alertItem.gcashReferenceNumber)),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Item Summary', style: TextStyle(fontSize: 16)),
              ),
              ...items.map((item) {
                return Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
              }).toList(),
              FlatButton(
                color: Colors.red,
                onPressed: () {
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
                      content: Text(
                          deleting ? 'Deleting Order... ' : 'Cancel Order?'),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: deleting
                              ? null
                              : () {
                                  Navigator.of(context).pop();
                                },
                          child: new Text("Cancel"),
                        ),
                        FlatButton(
                          onPressed: deleting
                              ? null
                              : () async {
                                  setState(() {
                                    deleting = true;
                                  });
                                  await deleteOrder();
                                  Navigator.popUntil(context,
                                      (Route<dynamic> route) => route.isFirst);
                                },
                          child: new Text("OK"),
                        )
                      ],
                    ),
                  );
                },
                child:
                    Text('CANCEL ORDER', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
