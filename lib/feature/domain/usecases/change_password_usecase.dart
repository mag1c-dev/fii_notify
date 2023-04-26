import '../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class ChangePasswordUsecase
    implements Usecase<Future<bool>, ChangePasswordParam> {
  ChangePasswordUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<bool> call(ChangePasswordParam param) {
    return _userRepository.changePassword(
        oldPassword: param.oldPassword,
        newPassword: param.newPassword,
        username: param.username);
  }
}

class ChangePasswordParam {
  ChangePasswordParam(this.oldPassword, this.newPassword, {this.username});

  String? username;
  String oldPassword;
  String newPassword;
}
