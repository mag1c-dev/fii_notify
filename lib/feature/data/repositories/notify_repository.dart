import 'package:fii_notify/feature/domain/repositories/notify_repository.dart';

import '../../domain/entities/notify.dart';
import '../data_sources/local/local_data_source.dart';
import '../data_sources/remote/remote_data_source.dart';

class NotifyRepositoryImpl extends NotifyRepository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  NotifyRepositoryImpl({
    required LocalDataSource localDataSource,
    required RemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<List<Notify>> getListNotify({
    String? source,
    String? user,
    int? group,
    int? latestId,
    int? page,
    int? size,
    NotifyType? notifyType,
  }) async {
    final result = await  _remoteDataSource.getListNotify(
        source: source,
        user: user,
        group: group,
        size: size,
        page: page,
        latestId: latestId, notifyType: notifyType);
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<int> getNotifyCount({
    String? source,
    String? user,
    int? group,
    int? latestId,
    int? page,
    int? size,
    NotifyType? notifyType,
  }) {
    return _remoteDataSource.getNotifyCount(
        source: source,
        user: user,
        group: group,
        size: size,
        page: page,
        latestId: latestId, notifyType: notifyType);
  }
}
