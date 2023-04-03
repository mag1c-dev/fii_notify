import 'package:fii_notify/feature/domain/entities/notify.dart';
import 'package:fii_notify/feature/domain/entities/notify_detail.dart';

import '../../../core/usecase/usecase.dart';
import '../repositories/notify_repository.dart';

class GetNotifyDetailUsecase implements Usecase<Future<NotifyDetail>, GetNotifyDetailUsecaseParams> {
  GetNotifyDetailUsecase({required NotifyRepository notifyRepository})
      : _repository = notifyRepository;

  final NotifyRepository _repository;

  @override
  Future<NotifyDetail> call(GetNotifyDetailUsecaseParams param) {
    return _repository.notifyDetail(id: param.id);
  }
}

class GetNotifyDetailUsecaseParams {
  int id;

  GetNotifyDetailUsecaseParams({
    required this.id,
  });
}
