import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmOrderGcash extends StatefulWidget {
  final totalPrice, totalItems, address, phoneNumber, name, referenceNumber;
  ConfirmOrderGcash({
    this.totalPrice,
    this.totalItems,
    this.address,
    this.phoneNumber,
    this.name,
    this.referenceNumber,
  });
  @override
  ConfirmOrderGcashState createState() => ConfirmOrderGcashState();
}

class ConfirmOrderGcashState extends State<ConfirmOrderGcash> {
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
                    DataCell(Text('Total Price')),
                    DataCell(Text('₱' + widget.totalPrice.toString())),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                elevation: 1.0,
                color: Colors.blue,
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
                      content: Text("Your order has been sent."),
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
