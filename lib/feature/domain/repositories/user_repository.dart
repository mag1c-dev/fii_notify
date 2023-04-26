import 'package:fii_notify/feature/domain/entities/user.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../entities/token.dart';

abstract class UserRepository {
  Stream<AuthenticationStatus> get authenticationStatus;

  Future<User> get user;

  Future<void> login({
    required String username,
    required String password,
  });

  Future<bool> changePassword({
    String? username,
    required String oldPassword,
    required String newPassword,
  });

  Future<String> resetPassword({
    required String username,
    required String citizenCode,
  });

  Future<void> logout();

  Future<Token> getToken();
}
