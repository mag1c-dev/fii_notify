import 'package:fresh_dio/fresh_dio.dart';

import '../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class GetLoginStatusUsecase
    extends Usecase<Stream<AuthenticationStatus>, NoParam> {
  GetLoginStatusUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;
  final UserRepository _userRepository;

  @override
  Stream<AuthenticationStatus> call(NoParam param) {
    return _userRepository.authenticationStatus;
  }
}
