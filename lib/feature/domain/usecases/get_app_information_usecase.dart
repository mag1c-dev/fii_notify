

import '../../../core/usecase/usecase.dart';
import '../entities/app_information.dart';
import '../entities/user.dart';
import '../repositories/app_repository.dart';
import '../repositories/user_repository.dart';

class GetAppInformationUsecase
    implements Usecase<Future<AppInformation>, GetAppInformationUsecaseParam> {
  GetAppInformationUsecase(
      {required AppRepository appRepository,
      required UserRepository userRepository}) {
    _appRepository = appRepository;
    _userRepository = userRepository;
  }

  late final AppRepository _appRepository;
  late final UserRepository _userRepository;

  @override
  Future<AppInformation> call(GetAppInformationUsecaseParam param) async {
    User? user;
    try {
      user = await _userRepository.user;
    } catch (_) {}
    final params = {
      'appName': 'FAIPacking',
      'version': param.version,
      'os': param.os,
      'uuid': param.uuid,
      'ipAddress': param.ipAddress,
      'bu': user?.bu,
      'cft': user?.cft,
      'empNo': user?.username,
    };
    return _appRepository.getAppInformation(params: params);
  }
}

class GetAppInformationUsecaseParam {
  final String? version;
  final String? os;
  final String? uuid;
  final String? ipAddress;

  const GetAppInformationUsecaseParam({
    this.version,
    this.os,
    this.uuid,
    this.ipAddress,
  });
}
