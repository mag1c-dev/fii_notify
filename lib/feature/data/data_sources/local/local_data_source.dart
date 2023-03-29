import '../../models/user_model.dart';

abstract class LocalDataSource {
  UserModel? getUser();

  void saveUser(UserModel? userModel);
}
