import '../entities/nearby_place_entity.dart';

abstract class NearbyRepositoryInterface {
  List<NearbyPlaceEntity> getNearbyPlaces();
  List<NearbyPlaceEntity> searchPlaces({required String query});
  List<NearbyPlaceEntity> filterByCategory({required String category});
}