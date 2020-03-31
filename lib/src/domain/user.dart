import 'package:firebase_auth/firebase_auth.dart';

class User {
  User(FirebaseUser firebaseUser)
      : id = firebaseUser.uid,
        name = firebaseUser.displayName,
        email = firebaseUser.email,
        phone = firebaseUser.phoneNumber;

  final String id;
  final String name;
  final String email;
  final String phone;

  @override
  String toString() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
      }.toString();
}
