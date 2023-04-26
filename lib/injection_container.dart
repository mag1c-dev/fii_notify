import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:fii_notify/feature/data/repositories/app_repository.dart';
import 'package:fii_notify/feature/domain/repositories/app_repository.dart';
import 'package:fii_notify/feature/domain/repositories/file_repository.dart';
import 'package:fii_notify/feature/domain/repositories/notify_repository.dart';
import 'package:fii_notify/feature/domain/repositories/source_repository.dart';
import 'package:fii_notify/feature/domain/usecases/cancel_download_usecase.dart';
import 'package:fii_notify/feature/domain/usecases/download_usecase.dart';
import 'package:fii_notify/feature/domain/usecases/get_app_information_usecase.dart';
import 'package:fii_notify/feature/domain/usecases/get_notify_count_usecase.dart';
import 'package:fii_notify/feature/domain/usecases/get_notify_detail_usecase.dart';
import 'package:fii_notify/feature/domain/usecases/get_notify_list_usecase.dart';
import 'package:fii_notify/feature/domain/usecases/get_source_list_usecase.dart';
import 'package:fii_notify/feature/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:fii_notify/feature/presentation/blocs/check_update/check_update_bloc.dart';
import 'package:fii_notify/feature/presentation/blocs/download/download_bloc.dart';
import 'package:get_it/get_it.dart';

import 'config/base_url_config.dart';
import 'core/utils/cache.dart';
import 'feature/data/data_sources/local/impl/local_data_source.dart';
import 'feature/data/data_sources/local/local_data_source.dart';
import 'feature/data/data_sources/remote/impl/remote_data_source_impl.dart';
import 'feature/data/data_sources/remote/remote_data_source.dart';
import 'feature/data/repositories/file_repository.dart';
import 'feature/data/repositories/notify_repository.dart';
import 'feature/data/repositories/source_repository.dart';
import 'feature/data/repositories/user_repository.dart';
import 'feature/domain/repositories/user_repository.dart';
import 'feature/domain/usecases/get_login_status_usecase.dart';
import 'feature/domain/usecases/get_login_user_usecase.dart';
import 'feature/domain/usecases/get_token_usecase.dart';
import 'feature/domain/usecases/login_usecase.dart';
import 'feature/domain/usecases/logout_usecase.dart';
import 'feature/presentation/blocs/setting/setting_bloc.dart';

final GetIt injector = GetIt.instance;

Future<void> initDependency() async {
  injector
    //Blocs
    ..registerLazySingleton(() => AuthenticationBloc())
    ..registerLazySingleton(() => SettingBloc())
    ..registerLazySingleton(() => DownloadBloc())
    ..registerLazySingleton(() => CheckUpdateBloc())

    //Usecases
    ..registerLazySingleton(() => LoginUsecase(userRepository: injector()))
    ..registerLazySingleton(() => LogoutUsecase(userRepository: injector()))
    ..registerLazySingleton(
        () => GetLoginStatusUsecase(userRepository: injector()))
    ..registerLazySingleton(
        () => GetLoginUserUsecase(userRepository: injector()))
    ..registerLazySingleton(
        () => GetNotifyListUsecase(notifyRepository: injector()))
    ..registerLazySingleton(
        () => GetNotifyDetailUsecase(notifyRepository: injector()))
    ..registerLazySingleton(
        () => GetNotifyCountUsecase(notifyRepository: injector()))
    ..registerLazySingleton(() => GetTokenUsecase(userRepository: injector()))
    ..registerLazySingleton(
        () => GetSourceListUsecase(sourceRepository: injector()))
    ..registerLazySingleton(
        () => GetAppInformationUsecase(appRepository: injector(), userRepository: injector()))
    ..registerLazySingleton(
        () => DownloadUsecase(fileRepository: injector()))
    ..registerLazySingleton(
        () => CancelDownloadUsecase(fileRepository: injector()))

    //repositories
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
          remoteDataSource: injector(), localDataSource: injector()),
    )
    ..registerLazySingleton<NotifyRepository>(
      () => NotifyRepositoryImpl(
          remoteDataSource: injector(), localDataSource: injector()),
    )
    ..registerLazySingleton<SourceRepository>(
      () => SourceRepositoryImpl(
          remoteDataSource: injector(), localDataSource: injector()),
    )
    ..registerLazySingleton<FileRepository>(
      () => FileRepositoryImpl(
          remoteDataSource: injector(), localDataSource: injector()),
    )
    ..registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(
          remoteDataSource: injector(), localDataSource: injector()),
    )
    //datasource
    ..registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
          cache: injector(),
        ))
    ..registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(
        httpClient: injector(),
        dioCacheManager: injector()
      ),
    )

    //core
    ..registerLazySingleton(Cache.new)
    ..registerLazySingleton(Dio.new)
    ..registerLazySingleton(() => DioCacheManager(
          CacheConfig(
            baseUrl: BaseUrlConfig().baseUrlProduction,
            defaultMaxStale: const Duration(days: 7),
            defaultMaxAge: const Duration(days: 7),
          ),

        ));
}
