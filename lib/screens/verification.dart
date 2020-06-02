import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_buddy/services/auth.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

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
            Text(
                "Waiting for email to be verified...\nPlease check your email"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    await auth.signOut();
                  },
                  child: new Text("Back",
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 20),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    await user.sendEmailVerification();
                  },
                  child:
                      new Text("Resend", style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
