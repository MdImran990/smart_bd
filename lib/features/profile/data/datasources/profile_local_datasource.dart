import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model.dart';

class ProfileLocalDatasource {
  static const _nameKey = 'profile_name';
  static const _emailKey = 'profile_email';
  static const _imageKey = 'profile_image';

  Future<ProfileModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return ProfileModel(
      name: prefs.getString(_nameKey) ?? '',
      email: prefs.getString(_emailKey) ?? '',
      imagePath: prefs.getString(_imageKey),
    );
  }

  Future<void> saveProfile({
    required String name,
    required String email,
    String? imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);

    if (imagePath != null) {
      await prefs.setString(_imageKey, imagePath);
    }
  }

  Future<String> saveImagePermanently(String sourcePath) async {
    final directory = await getApplicationDocumentsDirectory();

    final profileDirectory = Directory(
      '${directory.path}/profile',
    );

    if (!await profileDirectory.exists()) {
      await profileDirectory.create(recursive: true);
    }

    final extension = sourcePath.contains('.')
        ? sourcePath.split('.').last
        : 'jpg';

    final fileName =
        'profile_${DateTime.now().millisecondsSinceEpoch}.$extension';

    final savedPath = '${profileDirectory.path}/$fileName';

    final sourceFile = File(sourcePath);

    await sourceFile.copy(savedPath);

    return savedPath;
  }
}