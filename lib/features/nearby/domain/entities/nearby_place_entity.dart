class NearbyPlaceEntity {
  final String id;
  final String name;
  final String category;
  final String address;
  final double rating;
  final double distance;

  const NearbyPlaceEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.rating,
    required this.distance,
  });
}