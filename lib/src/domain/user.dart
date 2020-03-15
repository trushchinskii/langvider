import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;

  User(FirebaseUser firebaseUser)
      : id = firebaseUser.uid,
        name = firebaseUser.displayName,
        email = firebaseUser.email,
        phone = firebaseUser.phoneNumber;

  @override
  String toString() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
      }.toString();
}
