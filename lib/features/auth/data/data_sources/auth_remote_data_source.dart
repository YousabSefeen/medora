import 'package:medora/features/auth/data/models/user_model.dart'
    show UserModel;

abstract class AuthRemoteDataSource {
  Future<void> signUp({required UserModel userModel, required String password});

  Future<void> signIn({required String email, required String password});

  Future<String> getUserId();

  Future<void> signOut();
}
