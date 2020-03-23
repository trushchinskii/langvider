import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langvider/src/domain/user.dart';

class AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in in google account
  ///
  /// Return [User] if user login and null if doesn't
  Future<User> login() async {
    GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) return null;

    GoogleSignInAuthentication googleAuthentication =
        await googleAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuthentication.accessToken,
      idToken: googleAuthentication.idToken,
    );
    AuthResult authResult = await _auth.signInWithCredential(credential);

    if (authResult.user != null) {
      return User(authResult.user);
    } else {
      return null;
    }
  }

  Future<bool> get isUserAuthorized async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    return firebaseUser != null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
