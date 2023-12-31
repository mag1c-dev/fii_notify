import 'package:fii_notify/feature/data/models/notify_model.dart';
import 'package:fii_notify/feature/data/models/source_model.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../../../domain/entities/notify.dart';
import '../../models/app_information_model.dart';
import '../../models/file_download_model.dart';
import '../../models/notify_detail_model.dart';
import '../../models/token_model.dart';
import '../../models/user_model.dart';

abstract class RemoteDataSource {
  Stream<AuthenticationStatus> get authenticationStatus;

  Future<void> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<UserModel> getUserLogin();

  Future<TokenModel> getToken();

  Future<bool> changePassword({required String username, required String oldPassword, required String newPassword}) ;

  Future<String> resetPassword({required String username, required String citizenCode}) ;

  Future<List<NotifyModel>> getListNotify({
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
  Future<List<SourceModel>> getSources();
  Future<NotifyDetailModel> notifyDetail({required int id});

  Future<AppInformationModel> getAppInformation(
      {required Map<String, dynamic> params});

  Stream<FileDownloadModel> downloadFile({
    required String url,
    required String savePath,
  });

  void cancelDownload();
}
