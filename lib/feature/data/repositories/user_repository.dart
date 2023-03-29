import 'package:fresh_dio/fresh_dio.dart';

import '../../domain/entities/token.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/local/local_data_source.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    required LocalDataSource localDataSource,
    required RemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  @override
  Stream<AuthenticationStatus> get authenticationStatus =>
      _remoteDataSource.authenticationStatus;

  @override
  Future<User> get user async {
    return _localDataSource.getUser() ?? await _getUser();
  }

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {
    await _remoteDataSource.login(
      username: username,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
    _localDataSource.saveUser(null);
  }

  Future<UserModel> _getUser() async {
    final user = await _remoteDataSource.getUserLogin();
    _localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<bool> changePassword({
    String? username,
    required String oldPassword,
    required String newPassword,
  }) async {
    return _remoteDataSource.changePassword(
      username: username ?? (await user).username!,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<Token> getToken() {
    return _remoteDataSource.getToken();
  }

  @override
  Future<String> resetPassword({
    required String username,
    required String citizenCode,
  }) {
    return _remoteDataSource.resetPassword(
        username: username, citizenCode: citizenCode);
  }
}
