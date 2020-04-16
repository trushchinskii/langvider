import 'package:langvider/src/domain/user.dart';
import 'package:langvider/src/interactor/auth/repository/auth_repository.dart';

class AuthInteractor {
  AuthInteractor(this._repository);

  final AuthRepository _repository;

  Future<bool> get isUserLogin => _repository.isUserLogin;

  Future<User> get user => _repository.user;

  /// Sign in in google account
  ///
  /// Return [User] if user login and null if doesn't
  Future<bool> login() => _repository.login();

  Future<void> signOut() async => _repository.logout();
}
