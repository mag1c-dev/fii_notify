import 'package:fii_notify/feature/domain/entities/notify.dart';
import 'package:fii_notify/feature/domain/entities/source.dart';
import 'package:fii_notify/feature/domain/repositories/source_repository.dart';

import '../../../core/usecase/usecase.dart';
import '../repositories/notify_repository.dart';

class GetSourceListUsecase implements Usecase<Future<List<Source>>, NoParam> {
  GetSourceListUsecase({required SourceRepository sourceRepository})
      : _repository = sourceRepository;

  final SourceRepository _repository;

  @override
  Future<List<Source>> call(NoParam param) {
    return _repository.getSources();
  }
}