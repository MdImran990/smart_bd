class ProfileEntity {
  final String name;
  final String email;
  final String? imagePath;

  const ProfileEntity({
    required this.name,
    required this.email,
    this.imagePath,
  });
}