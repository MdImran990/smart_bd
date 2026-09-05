import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/datasources/profile_local_datasource.dart';
import '../../data/models/profile_model.dart';

final profileDatasourceProvider =
Provider<ProfileLocalDatasource>((ref) {
  return ProfileLocalDatasource();
});

final profileProvider =
NotifierProvider<ProfileNotifier, ProfileModel>(
  ProfileNotifier.new,
);

class ProfileNotifier extends Notifier<ProfileModel> {
  late final ProfileLocalDatasource _datasource;

  @override
  ProfileModel build() {
    _datasource = ref.read(profileDatasourceProvider);

    Future.microtask(_loadProfile);

    return const ProfileModel(
      name: '',
      email: '',
      imagePath: null,
    );
  }

  Future<void> _loadProfile() async {
    final profile = await _datasource.getProfile();
    state = profile;
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    await _datasource.saveProfile(
      name: name,
      email: email,
    );

    state = state.copyWith(
      name: name,
      email: email,
    );
  }

  Future<void> updateProfileImage(
      ImageSource source,
      ) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile == null) return;

    final savedPath = await _datasource.saveImagePermanently(
      pickedFile.path,
    );

    await _datasource.saveProfile(
      name: state.name,
      email: state.email,
      imagePath: savedPath,
    );

    state = state.copyWith(
      imagePath: savedPath,
    );
  }

  bool hasValidImage() {
    if (state.imagePath == null) return false;

    return File(state.imagePath!).existsSync();
  }
}