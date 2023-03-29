import 'package:fii_notify/feature/domain/entities/source.dart';
import 'package:fii_notify/feature/domain/repositories/source_repository.dart';

import '../data_sources/local/local_data_source.dart';
import '../data_sources/remote/remote_data_source.dart';

class SourceRepositoryImpl implements SourceRepository {

  SourceRepositoryImpl({
    required LocalDataSource localDataSource,
    required RemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;



  @override
  Future<List<Source>> getSources() {
    return _remoteDataSource.getSources();
  }

}
