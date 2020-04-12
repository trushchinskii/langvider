import 'package:flutter/foundation.dart';
import 'package:langvider/src/ui/utils/consts.dart';

class User {
  User({
    @required String id,
    @required String name,
    @required String email,
    @required String phone,
  })  : id = id ?? emptyString,
        name = name ?? emptyString,
        email = email ?? emptyString,
        phone = phone ?? emptyString;

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
