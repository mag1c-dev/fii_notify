import '../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class LogoutUsecase extends Usecase<Future<void>, NoParam> {
  LogoutUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<void> call(NoParam param) {
    return _userRepository.logout();
  }
}
