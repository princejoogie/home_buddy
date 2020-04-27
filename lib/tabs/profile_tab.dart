import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  String email;
  ProfileTab({this.email});

  @override
  _ProfileTabState createState() => _ProfileTabState(email);
}

class _ProfileTabState extends State<ProfileTab> {
  String email;

  _ProfileTabState(this.email);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile Tab"),
    );
  }
}
