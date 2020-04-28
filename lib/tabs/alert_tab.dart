import 'package:flutter/material.dart';

class AlertTab extends StatefulWidget {
  final String email;
  AlertTab({this.email});
  @override
  _AlertTabState createState() => _AlertTabState(email);
}

class _AlertTabState extends State<AlertTab> {
  String email;

  _AlertTabState(this.email);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              child: Text(
                "ALERTS",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
