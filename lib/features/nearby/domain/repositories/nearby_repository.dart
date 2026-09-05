import '../entities/nearby_place_entity.dart';

abstract class NearbyRepositoryInterface {
  List<NearbyPlaceEntity> getNearbyPlaces();
}