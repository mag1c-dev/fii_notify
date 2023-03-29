
import '../../../core/usecase/usecase.dart';
import '../entities/token.dart';
import '../repositories/user_repository.dart';

class GetTokenUsecase implements Usecase<Future<void>, NoParam> {
  GetTokenUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<Token> call(NoParam param) {
    return _userRepository.getToken();
  }
}
