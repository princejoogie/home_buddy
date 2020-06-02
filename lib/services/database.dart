import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // User Reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(
      {String username,
      String email,
      String firstName,
      String lastName}) async {
    return await userCollection.document(uid).setData({
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'coverImage': null,
      'profileImage': null,
    });
  }

  Stream<DocumentSnapshot> get user {
    return userCollection.document(uid).snapshots();
  }
}
