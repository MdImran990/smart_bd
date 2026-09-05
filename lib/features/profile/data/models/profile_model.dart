class ProfileModel {
  final String name;
  final String email;
  final String? imagePath;

  const ProfileModel({
    required this.name,
    required this.email,
    this.imagePath,
  });

  ProfileModel copyWith({
    String? name,
    String? email,
    String? imagePath,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}