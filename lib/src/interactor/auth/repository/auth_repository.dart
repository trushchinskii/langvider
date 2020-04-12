import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/interactor/auth/repository/dto/user_dto.dart';
import 'package:langvider/src/interactor/common/base/base_repository.dart';

class AuthRepository extends BaseRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> get user => _auth.currentUser().then(
        (firebaseUser) => UserDto(firebaseUser).transform(),
      );

  /// Sign in in google account
  ///
  /// Return [User] if user login and null if doesn't
  Future<bool> login() async {
    try {
      final FirebaseUser firebaseUser = await _loginByGoogle();
      return firebaseUser != null;
    } on Exception catch (e) {
      handleCommonException(e);
    }

    return false;
  }

  /// Return null if login was aborted
  Future<FirebaseUser> _loginByGoogle() async {
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) return null;

    final GoogleSignInAuthentication googleAuthentication =
        await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuthentication.accessToken,
      idToken: googleAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);

    return authResult.user;
  }

  Future<bool> get isUserLogin async {
    try {
      final FirebaseUser firebaseUser = await _auth.currentUser();
      return firebaseUser != null;
    } on Exception catch (e) {
      handleCommonException(e);
    }

    return false;
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } on Exception catch (e) {
      handleCommonException(e);
    }
  }
}
