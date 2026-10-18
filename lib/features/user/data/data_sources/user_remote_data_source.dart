import 'package:medora/features/user/data/models/user_model.dart';

import '../../domain/value_objects/add_user_params.dart';

abstract class UserRemoteDataSource {
  Future<void> addUser({required AddUserParams params});

  Future<UserModel> getUserData();
}
