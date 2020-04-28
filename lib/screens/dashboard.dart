import 'package:flutter/material.dart';
import 'package:home_buddy/tabs/cart_tab.dart';
import 'package:home_buddy/tabs/home_tab.dart';
import 'package:home_buddy/tabs/profile_tab.dart';
import 'package:home_buddy/tabs/alert_tab.dart';

class DashboardScreen extends StatefulWidget {
  final String email, username, firstName, lastName;

  DashboardScreen({this.email, this.username, this.firstName, this.lastName});

  @override
  _DashboardScreenState createState() =>
      _DashboardScreenState(email, username, firstName, lastName);
}

class _DashboardScreenState extends State<DashboardScreen> {
  int tabIndex = 0;
  String email = "N/A", username = "N/A", firstName = "N/A", lastName = "N/A";

  _DashboardScreenState(
      this.email, this.username, this.firstName, this.lastName);

  List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    print("EMAIL: " + email);
    listScreens = [
      HomeTab(
        key: PageStorageKey('HomeTab'),
        email: email,
      ),
      AlertTab(email: email),
      CartTab(email: email),
      ProfileTab(
        email: email,
        username: username,
        firstName: firstName,
        lastName: lastName,
      ),
    ];
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: PageStorage(
        child: SafeArea(
          child: listScreens[tabIndex],
        ),
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 30.0,
        selectedItemColor: Color(0xFF007BFF),
        unselectedItemColor: Color(0xFF6FBAF7),
        backgroundColor: Color(0xFFFFFFFF),
        currentIndex: tabIndex,
        onTap: (int index) {
          setState(() {
            tabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            title: Text('Alerts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
