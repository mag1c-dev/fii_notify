
import '../entities/file_download.dart';

abstract class FileRepository {
  Stream<FileDownload> download({
    required String url,
    required String savePath,
  });

  void cancelDownload();
}
