import 'package:flutter/material.dart';

class AlertTab extends StatefulWidget {
  String email;
  AlertTab({this.email});
  @override
  _AlertTabState createState() => _AlertTabState(email);
}

class _AlertTabState extends State<AlertTab> {
  String email;

  _AlertTabState(this.email);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Alert Tab"),
    );
  }
}
