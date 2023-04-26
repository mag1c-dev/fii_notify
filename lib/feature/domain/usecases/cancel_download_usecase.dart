
import '../../../core/usecase/usecase.dart';
import '../repositories/file_repository.dart';

class CancelDownloadUsecase extends Usecase<void, NoParam> {
  CancelDownloadUsecase({required FileRepository fileRepository})
      : _fileRepository = fileRepository;

  final FileRepository _fileRepository;

  @override
  void call(NoParam param) {
    return _fileRepository.cancelDownload();
  }
}
