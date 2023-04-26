import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:fii_notify/config/base_url_config.dart';
import 'package:fii_notify/feature/data/models/notify_detail_model.dart';
import 'package:fii_notify/feature/data/models/notify_model.dart';
import 'package:fii_notify/feature/data/models/source_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../../../../../core/utils/token_preferences_storage.dart';
import '../../../../domain/entities/file_download.dart';
import '../../../../domain/entities/notify.dart';
import '../../../models/app_information_model.dart';
import '../../../models/file_download_model.dart';
import '../../../models/response_wrapper.dart';
import '../../../models/token_model.dart';
import '../../../models/user_model.dart';
import '../remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({Dio? httpClient, DioCacheManager? dioCacheManager}) {
    _dioCacheManager = dioCacheManager ??
        DioCacheManager(
          CacheConfig(
            baseUrl: BaseUrlConfig().baseUrlProduction,
          ),
        );
    _httpClient = ((httpClient ?? Dio())
      ..options.baseUrl = BaseUrlConfig().baseUrlProduction
      ..options.connectTimeout = 60000
      ..options.sendTimeout = 60000
      ..options.receiveTimeout = 60000
      ..interceptors.add(_fresh))
      ..interceptors.add(_dioCacheManager.interceptor)
      ..interceptors.add(LogInterceptor());
  }

  late final Dio _httpClient;

  late final DioCacheManager _dioCacheManager;

  CancelToken? cancelToken;


  DioCacheManager get dioCacheManager {
    return _dioCacheManager;
  }

  static final _fresh = Fresh.oAuth2(
    tokenStorage: TokenPreferencesStorage(),
    refreshToken: (token, client) async {
      final result = await Dio().post<Map<String, dynamic>>(
        '${BaseUrlConfig().baseUrlProduction}oauth-service/oauth/token',
        data: {
          'refresh_token': token?.refreshToken,
          'grant_type': 'refresh_token'
        },
        options: Options(
          headers: {
            'Authorization': 'Basic d3Mtc3lzdGVtOkZveGNvbm4xNjghIQ==',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      final newToken =
          TokenModel.fromJson(result.data!).copyWith(tokenType: 'Bearer');
      return newToken;
    },
    shouldRefresh: (response) {
      return response?.statusCode == 401;
    },
    tokenHeader: (token) {
      return {'Authorization': 'Bearer ${token.accessToken}'};
    },
  );

  @override
  Stream<AuthenticationStatus> get authenticationStatus =>
      _fresh.authenticationStatus;

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {
    final result = await _httpClient.post<Map<String, dynamic>>(
      'oauth-service/oauth/token',
      data: {
        'username': username,
        'password': password,
        'grant_type': 'password'
      },
      options: Options(
        headers: {
          'Authorization': 'Basic d3Mtc3lzdGVtOkZveGNvbm4xNjghIQ==',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );
    final token = TokenModel.fromJson(result.data!);
    await _fresh.setToken(
      token,
    );
  }

  @override
  Future<void> logout() async {
    await _fresh.setToken(null);
  }

  @override
  Future<UserModel> getUserLogin() async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'peachat/api/user/me',
      options: buildCacheOptions(
        const Duration(days: 3),
        maxStale: const Duration(days: 7),
        forceRefresh: true,
      ),
    );
    final wrapper = ResponseWrapper<UserModel>.fromJson(
      result.data!,
      (json) => UserModel.fromJson(json! as Map<String, dynamic>),
    );
    return wrapper.result!;
  }

  @override
  Future<TokenModel> getToken() async {
    final token = await _fresh.token;
    return token! as TokenModel;
  }

  @override
  Future<bool> changePassword(
      {required String username,
      required String oldPassword,
      required String newPassword}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<String> resetPassword(
      {required String username, required String citizenCode}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<List<NotifyModel>> getListNotify({
    String? source,
    String? user,
    int? group,
    int? latestId,
    int? page,
    int? size,
    NotifyType? notifyType,
  }) async {
    final params = {
      'source': source,
      'user': user,
      'group': group,
      'latestId': latestId,
      'page': page,
      'size': size,
      'notifyType': notifyType?.json
    };

    final result = await _httpClient.get<Map<String, dynamic>>(
      'notify-service/api/message',
      queryParameters: params,
      options: buildCacheOptions(const Duration(days: 3),
          maxStale: const Duration(days: 7),
          forceRefresh: true,
          primaryKey: 'notify-service/api/notify/${params.values.join(',')}'),
    );
    final wrapper = ResponseWrapper<List<NotifyModel>>.fromJson(
      result.data!,
      (json) => (json as List).map((e) => NotifyModel.fromJson(e)).toList(),
    );
    return wrapper.data!;
  }

  @override
  Future<int> getNotifyCount(
      {String? source,
      String? user,
      int? group,
      int? latestId,
      int? page,
      int? size,     NotifyType? notifyType,
      }) async {
    final params = {
      'source': source,
      'user': user,
      'group': group,
      'latestId': latestId,
      'page': page,
      'size': size,
      'notifyType': notifyType?.json

    };

    final result = await _httpClient.get<Map<String, dynamic>>(
      'notify-service/api/message/number',
      queryParameters: params,
      options: buildCacheOptions(
        const Duration(days: 3),
        maxStale: const Duration(days: 7),
        forceRefresh: true,
      ),
    );
    final wrapper = ResponseWrapper<int>.fromJson(
      result.data!,
      (json) => json as int,
    );
    return wrapper.result!;
  }

  @override
  Future<List<SourceModel>> getSources() async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'notify-service/api/source',
      options: buildCacheOptions(
        const Duration(days: 3),
        maxStale: const Duration(days: 7),
        forceRefresh: true,
      ),
    );
    final wrapper = ResponseWrapper<List<SourceModel>>.fromJson(
      result.data!,
      (json) => (json as List).map((e) => SourceModel.fromJson(e)).toList(),
    );
    return wrapper.data!;
  }

  @override
  Future<NotifyDetailModel> notifyDetail({required int id}) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'notify-service/api/message/$id',
      options: buildCacheOptions(
        const Duration(days: 3),
        maxStale: const Duration(days: 7),
        forceRefresh: true,
      ),
    );
    final wrapper = ResponseWrapper<NotifyModel>.fromJson(
      result.data!,
      (json) =>  NotifyModel.fromJson(json as Map<String, dynamic>),
    );
    return NotifyDetailModel();
  }


  @override
  Future<AppInformationModel> getAppInformation(
      {required Map<String, dynamic> params}) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      '/fiistore/getVersion',
      queryParameters: params,
    );
    final wrapper = ResponseWrapper<AppInformationModel>.fromJson(result.data!,
            (json) => AppInformationModel.fromJson(json as Map<String, dynamic>));

    if (wrapper.result == null || wrapper.status == 0) {
      throw wrapper.message ?? 'Server error.';
    }
    return wrapper.result!;
  }

  @override
  Stream<FileDownloadModel> downloadFile({
    required String url,
    required String savePath,
  }) {
    final fileDownload = FileDownloadModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: savePath.split('/').last,
      path: savePath,
      url: url,
    );

    final fileDownloadStream = StreamController<FileDownloadModel>.broadcast();

    _httpClient.download(
      url,
      savePath,
      cancelToken: cancelToken = CancelToken(),
      onReceiveProgress: (count, total) {
        fileDownloadStream.sink.add(
          fileDownload.copyWith(
            size: total,
            downloaded: count,
            status: count == total
                ? DownloadStatus.success
                : DownloadStatus.downloading,
          ),
        );
        if (count == total) {
          fileDownloadStream.close();
        }
      },
    );

    return fileDownloadStream.stream;
  }

  @override
  void cancelDownload() {
    cancelToken?.cancel();
  }
}
