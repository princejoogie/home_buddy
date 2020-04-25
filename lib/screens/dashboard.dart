import 'package:flutter/material.dart';
import 'package:home_buddy/tabs/cart_tab.dart';
import 'package:home_buddy/tabs/home_tab.dart';
import 'package:home_buddy/tabs/profile_tab.dart';
import 'package:home_buddy/tabs/alert_tab.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int tabIndex = 0;

  List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    listScreens = [
      HomeTab(
        key: PageStorageKey('HomeTab'),
      ),
      AlertTab(
        key: PageStorageKey('AlertTab'),
      ),
      CartTab(
        key: PageStorageKey('CartTab'),
      ),
      ProfileTab(
        key: PageStorageKey('ProfileTab'),
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
        elevation: 10.0,
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
