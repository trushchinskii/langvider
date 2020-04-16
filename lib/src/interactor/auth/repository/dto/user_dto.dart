import 'package:firebase_auth/firebase_auth.dart';
import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/ui/utils/transformable.dart';

class UserDto implements Transformable<User> {
  UserDto(this._firebaseUser);

  final FirebaseUser _firebaseUser;

  @override
  User transform() => User(
        id: _firebaseUser.uid,
        name: _firebaseUser.displayName,
        email: _firebaseUser.email,
        phone: _firebaseUser.phoneNumber,
      );
}
