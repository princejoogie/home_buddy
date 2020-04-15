import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Image(
                image: AssetImage('assets/topRec.png'),
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
              child: Image(
                image: AssetImage('assets/botRec.png'),
              ),
            ),
            Center(
              child: Container(
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
                            color: Color(0xFF3D39E4),
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              /*...*/
                            },
                            child: Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
