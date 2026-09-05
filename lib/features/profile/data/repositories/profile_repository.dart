import '../datasources/profile_local_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  final ProfileLocalDatasource _datasource;

  ProfileRepository() : _datasource = ProfileLocalDatasource();

  Future<ProfileModel> getProfile() async {
    return await _datasource.getProfile();
  }

  Future<void> saveProfile({
    required String name,
    required String email,
    String? imagePath,
  }) async {
    await _datasource.saveProfile(
      name: name,
      email: email,
      imagePath: imagePath,
    );
  }

  Future<String> saveImagePermanently(String sourcePath) async {
    return await _datasource.saveImagePermanently(sourcePath);
  }
}