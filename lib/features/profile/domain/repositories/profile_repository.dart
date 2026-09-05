import '../entities/profile_entity.dart';

abstract class ProfileRepositoryInterface {
  Future<ProfileEntity> getProfile();
  Future<void> saveProfile({
    required String name,
    required String email,
    String? imagePath,
  });
}