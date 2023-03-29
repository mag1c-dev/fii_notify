import 'package:fii_notify/feature/domain/entities/source.dart';

abstract class SourceRepository {
  Future<List<Source>> getSources();

}
