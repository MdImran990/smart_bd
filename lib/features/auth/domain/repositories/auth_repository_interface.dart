import '../entities/user_entity.dart';

abstract class AuthRepositoryInterface {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> forgotPassword({required String email});
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
  Future<bool> isLoggedIn();
}