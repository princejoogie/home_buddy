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
  String email, username, firstName, lastName, profileImage, coverImage;
  bool saved = false;

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
      profileImage = prefs.getString('profileImage');
      coverImage = prefs.getString('coverImage');
    });

    if (username != null) {
      setState(() {
        saved = true;
      });
    } else {
      setState(() {
        saved = false;
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
      home: !saved
          ? LoginScreen()
          : DashboardScreen(
              email: email,
              username: username,
              firstName: firstName,
              lastName: lastName,
              profileImage: profileImage,
              coverImage: coverImage,
            ),
    );
  }
}
