import 'package:fii_notify/feature/domain/entities/notify.dart';

import '../../../core/usecase/usecase.dart';
import '../repositories/notify_repository.dart';

class GetNotifyCountUsecase implements Usecase<Future<int>, GetNotifyCountUsecaseParams> {
  GetNotifyCountUsecase({required NotifyRepository notifyRepository})
      : _repository = notifyRepository;

  final NotifyRepository _repository;

  @override
  Future<int> call(GetNotifyCountUsecaseParams param) {
    return _repository.getNotifyCount(
      source: param.source,
      user: param.user,
      group: param.group,
      latestId: param.latestId,
      page: param.page,
      size: param.size,
    );
  }
}

class GetNotifyCountUsecaseParams {
  String? source;
  String? user;
  int? group;
  int? latestId;
  int? page;
  int? size;

  GetNotifyCountUsecaseParams(
      {this.source, this.user, this.group, this.latestId, this.page, this.size});
}
