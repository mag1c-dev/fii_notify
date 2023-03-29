import '../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class LoginUsecase implements Usecase<Future<void>, LoginParam> {
  LoginUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<void> call(LoginParam param) {
    return _userRepository.login(
        username: param.username, password: param.password);
  }
}

class LoginParam {
  LoginParam(this.username, this.password);

  String username;
  String password;
}
