import 'package:fii_notify/feature/domain/entities/user.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../entities/notify.dart';
import '../entities/token.dart';

abstract class NotifyRepository {
  Future<List<Notify>> getListNotify({
    String? source,
    String? user,
    int? group,
    int? latestId,
    int? page,
    int? size,
    NotifyType? notifyType,
  });
  Future<int> getNotifyCount({
    String? source,
    String? user,
    int? group,
    int? latestId,
    int? page,
    int? size,
    NotifyType? notifyType,
  });
}
