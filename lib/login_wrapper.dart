import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy/screens/dashboard.dart';
import 'package:home_buddy/screens/login_screen.dart';
import 'package:home_buddy/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return LoginScreen();
    } else {
      return StreamProvider<DocumentSnapshot>.value(
        value: DatabaseService(
          uid: user.uid,
        ).user,
        child: DashboardScreen(),
      );
    }
  }
}
