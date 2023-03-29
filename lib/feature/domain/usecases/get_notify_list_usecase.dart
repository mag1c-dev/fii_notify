import 'package:fii_notify/feature/domain/entities/notify.dart';

import '../../../core/usecase/usecase.dart';
import '../repositories/notify_repository.dart';

class GetNotifyListUsecase implements Usecase<Future<List<Notify>>, GetNotifyListUsecaseParams> {
  GetNotifyListUsecase({required NotifyRepository notifyRepository})
      : _repository = notifyRepository;

  final NotifyRepository _repository;

  @override
  Future<List<Notify>> call(GetNotifyListUsecaseParams param) {
    return _repository.getListNotify(
      source: param.source,
      user: param.user,
      group: param.group,
      latestId: param.latestId,
      page: param.page,
      size: param.size,
      notifyType: param.notifyType
    );
  }
}

class GetNotifyListUsecaseParams {
  String? source;
  String? user;
  int? group;
  int? latestId;
  int? page;
  int? size;
  NotifyType? notifyType;

  GetNotifyListUsecaseParams({
    this.source,
    this.user,
    this.group,
    this.latestId,
    this.page,
    this.size,
    this.notifyType,
  });
}
