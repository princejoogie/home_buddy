import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_buddy/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  // Sign in Anonymously
  Future signInAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print('--------------------------------');
      print(e.toString());
      print('--------------------------------');
      return e;
    }
  }

  // Sign in with Email & Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print('--------------------------------');
      print(e.toString());
      print('--------------------------------');
      return e;
    }
  }

  // Register with Email & Password+
  Future signUpWithEmailAndPassword(
      {String email,
      String password,
      String username,
      String firstName,
      String lastName}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      await user.sendEmailVerification();

      await DatabaseService(uid: user.uid).updateUserData(
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
      return user;
    } catch (e) {
      print('--------------------------------');
      print(e.toString());
      print('--------------------------------');
      return e;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('--------------------------------');
      print(e.toString());
      print('--------------------------------');
      return e;
    }
  }
}
