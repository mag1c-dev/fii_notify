
import '../../../core/usecase/usecase.dart';
import '../entities/file_download.dart';
import '../repositories/file_repository.dart';

class DownloadUsecase extends Usecase<Stream<FileDownload>, DownloadParams> {
  DownloadUsecase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  final FileRepository _fileRepository;

  @override
  Stream<FileDownload> call(DownloadParams param) {
    return _fileRepository.download(url: param.url, savePath: param.savePath);
  }
}

class DownloadParams {
  DownloadParams({required this.url, required this.savePath});
  String url;
  String savePath;
}
