import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/screens/dashboard.dart';
import 'package:home_buddy/screens/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _loading = false;

  Widget _buildInputForm() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Email or Username',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF7B7676),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFFEF5F5),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: username,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF7B7676),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFFEF5F5),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                obscureText: true,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showError(String title, String msg) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _putUserData(
      email, username, firstName, lastName, profileImage, coverImage) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
    await prefs.setString('username', username);
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('profileImage', profileImage);
    await prefs.setString('coverImage', coverImage);
  }

  Future<void> _login() async {
    if (username.text.length <= 0 || password.text.length <= 0) {
      _showError("Warning", "One or more fields are empty.");
    } else {
      var uname = username.text.trim();
      var pw = password.text.trim();

      final response = await http.post(
        loginAPI,
        body: {
          'uname': uname,
          'password': pw,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data[0] == 'success') {
          if (!mounted) return;
          setState(() {
            _loading = false;
          });

          await _putUserData(
            data[1]['email'],
            data[1]['username'],
            data[1]['first_name'],
            data[1]['last_name'],
            data[1]['profile_image'],
            data[1]['cover_image'],
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DashboardScreen(
                email: data[1]['email'],
                username: data[1]['username'],
                firstName: data[1]['first_name'],
                lastName: data[1]['last_name'],
                profileImage: data[1]['profile_image'],
                coverImage: data[1]['cover_image'],
              ),
            ),
          );
        } else {
          _showError("Login Failed", data[0]);
        }
      } else {
        _showError("Network Error", "Error Connecting");
      }
    }
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: MediaQuery.of(context).size.height / 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF007BFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 50,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 50),
                alignment: Alignment.center,
                width: 100,
                height: MediaQuery.of(context).size.height / 2 / 2,
                decoration: BoxDecoration(
                  color: Color(0xFF007BFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 21,
                      height: 21,
                      decoration: BoxDecoration(
                        color: Color(0xFF6FBAF7),
                        borderRadius: BorderRadius.circular(21 / 2),
                      ),
                    ),
                    Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: Color(0xFF6FBAF7),
                        borderRadius: BorderRadius.circular(11 / 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 260,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xFF002CB8),
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                splashColor: Colors.blueAccent,
                                onPressed: () {
                                  setState(() {
                                    _loading = true;
                                  });
                                  _login();
                                },
                                child: _loading
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0),
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        "Login",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        _buildInputForm(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xFF7B7676),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
