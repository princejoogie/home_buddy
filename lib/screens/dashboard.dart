import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_buddy/tabs/cart_tab.dart';
import 'package:home_buddy/tabs/home_tab.dart';
import 'package:home_buddy/tabs/profile_tab.dart';
import 'package:home_buddy/tabs/alert_tab.dart';
import 'package:provider/provider.dart';
import 'package:home_buddy/services/auth.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('hello world'),
          RaisedButton(
            onPressed: () async {
              await auth.signOut();
            },
            child: Text('Button'),
          ),
        ],
      ),
    );
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  int tabIndex = 0;
  List<Widget> listScreens;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DocumentSnapshot>(context);

    if (data == null) {
      return Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCube(
              color: Colors.blue,
              size: 50.0,
            ),
            SizedBox(height: 30.0),
            Text("Loading Data..."),
          ],
        )),
      );
    } else {
      setState(() {
        listScreens = [
          // TestScreen(),
          HomeTab(key: PageStorageKey('HomeTab'), email: data['email']),
          AlertTab(email: data['email']),
          CartTab(email: data['email']),
          ProfileTab(
            email: data['email'],
            username: data['username'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            coverImage: data['coverImage'],
            profileImage: data['profileImage'],
          ),
        ];
      });
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
}
