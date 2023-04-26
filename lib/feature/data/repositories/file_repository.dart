
import 'package:fii_notify/feature/data/data_sources/local/local_data_source.dart';

import '../../domain/repositories/file_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/file_download_model.dart';

class FileRepositoryImpl extends FileRepository {
  FileRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Stream<FileDownloadModel> download(
      {required String url, required String savePath}) {
    return remoteDataSource.downloadFile(url: url, savePath: savePath);
  }

  @override
  void cancelDownload() {
    remoteDataSource.cancelDownload();
  }
}
