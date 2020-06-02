import 'package:flutter/material.dart';
import 'package:home_buddy/host_details.dart';
import 'package:home_buddy/services/auth.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();
  bool loading = false;
  String _email = "",
      _password = "",
      _username = "",
      _firstName = "",
      _lastName = "",
      error = "";

  Future<void> _register(
      {firstName, lastName, username, email, password}) async {
    final response = await http.post(
      registerAPI,
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      if (response.body == 'success') {
        Navigator.of(context).pop();
      } else {
        _showError("Registration Failed", response.body);
      }
    } else {
      _showError("Network Error", "Error Connecting");
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20.0),
                child: Row(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        radius: 25,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "REGISTER",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'First Name is required' : null,
                            onChanged: (val) {
                              setState(() {
                                _firstName = val.trim();
                                error = "";
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.grey),
                              border: OutlineInputBorder(),
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: 'First Name',
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Last Name is required' : null,
                            onChanged: (val) {
                              setState(() {
                                _lastName = val.trim();
                                error = "";
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.grey),
                              border: OutlineInputBorder(),
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: 'Last Name',
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Username is required' : null,
                            onChanged: (val) {
                              setState(() {
                                _username = val.trim();
                                error = "";
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.grey),
                              border: OutlineInputBorder(),
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: 'Username',
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) =>
                                val.isEmpty ? 'Email is required' : null,
                            onChanged: (val) {
                              setState(() {
                                _email = val.trim();
                                error = "";
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email, color: Colors.grey),
                              border: OutlineInputBorder(),
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            validator: (val) =>
                                val.length < 6 ? 'Password is too short' : null,
                            obscureText: true,
                            autocorrect: false,
                            onChanged: (val) {
                              setState(() {
                                _password = val.trim();
                                error = "";
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.grey),
                              border: OutlineInputBorder(),
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          RaisedButton(
                            elevation: 1.0,
                            color: Colors.blue,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                if (!mounted) {
                                  setState(() => loading = true);
                                }
                                await _register(
                                  firstName: _firstName,
                                  lastName: _lastName,
                                  username: _username,
                                  email: _email,
                                  password: _password,
                                );
                                await auth.signUpWithEmailAndPassword(
                                  email: _email,
                                  password: _password,
                                  username: _username,
                                  firstName: _firstName,
                                  lastName: _lastName,
                                );
                              }
                            },
                            child: loading
                                ? CircularProgressIndicator()
                                : Text('Sign Up',
                                    style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            error,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
