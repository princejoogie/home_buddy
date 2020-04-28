import 'package:flutter/material.dart';
import 'package:home_buddy/screens/dashboard.dart';
import './screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String email, username, firstName, lastName;
  int val = 0;

  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      email = prefs.getString('email');
      username = prefs.getString('username');
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
    });

    if (username != null) {
      setState(() {
        val = 1;
      });
    } else {
      setState(() {
        val = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: val == 0
          ? LoginScreen()
          : DashboardScreen(
              email: email,
              username: username,
              firstName: firstName,
              lastName: lastName,
            ),
    );
  }
}
