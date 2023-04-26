import '../../domain/entities/app_information.dart';
import '../../domain/repositories/app_repository.dart';
import '../data_sources/local/local_data_source.dart';
import '../data_sources/remote/remote_data_source.dart';

class AppRepositoryImpl extends AppRepository{
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  AppRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<AppInformation> getAppInformation({required Map<String, dynamic> params}) {
    return remoteDataSource.getAppInformation(params: params);
  }

}
