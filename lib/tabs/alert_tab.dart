import 'package:flutter/material.dart';

class AlertTab extends StatefulWidget {
  const AlertTab({Key key}) : super(key: key);

  @override
  _AlertTabState createState() => _AlertTabState();
}

class _AlertTabState extends State<AlertTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Alert Tab"),
    );
  }
}
