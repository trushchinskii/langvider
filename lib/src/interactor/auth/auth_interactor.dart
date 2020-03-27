import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/interactor/auth/repository/auth_repository.dart';

class AuthInteractor {
  AuthInteractor(this._authRepository);

  final AuthRepository _authRepository;

  /// Sign in in google account
  ///
  /// Return [User] if user login and null if doesn't
  Future<User> login() => _authRepository.login();

  Future<bool> get isUserLogin => _authRepository.isUserLogin;

  Future<void> signOut() async => _authRepository.logout();
}
