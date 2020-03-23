import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/interactors/auth/repository/auth_repository.dart';

class AuthInteractor {
  final AuthRepository _authRepository;

  AuthInteractor(
    this._authRepository,
  );

  /// Sign in in google account
  ///
  /// Return [User] if user login and null if doesn't
  Future<User> login() => _authRepository.login();

  Future<bool> get isUserAuth => _authRepository.isUserAuthorized;

  Future<void> signOut() async => _authRepository.signOut();
}
