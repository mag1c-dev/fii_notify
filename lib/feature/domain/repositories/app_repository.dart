
import '../entities/app_information.dart';

abstract class AppRepository {

  Future<AppInformation> getAppInformation({required Map<String, dynamic> params});
}
