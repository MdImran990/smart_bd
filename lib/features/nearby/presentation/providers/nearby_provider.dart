import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/models/nearby_place_model.dart';
import '../../data/repositories/nearby_repository.dart';

final nearbyRepositoryProvider = Provider<NearbyRepository>((ref) {
  return NearbyRepository();
});

final nearbyPlacesProvider =
FutureProvider<List<NearbyPlaceModel>>((ref) async {
  final repository = ref.watch(nearbyRepositoryProvider);
  return repository.getNearbyPlaces();
});

// Search
final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

// Category
final selectedCategoryProvider = StateProvider<String>((ref) {
  return 'All';
});

// Favorites
final favoritePlacesProvider =
StateNotifierProvider<FavoritePlacesNotifier, Set<String>>((ref) {
  return FavoritePlacesNotifier();
});

class FavoritePlacesNotifier extends StateNotifier<Set<String>> {
  FavoritePlacesNotifier() : super(<String>{});

  void toggleFavorite(String placeId) {
    final newState = <String>{...state};

    if (newState.contains(placeId)) {
      newState.remove(placeId);
    } else {
      newState.add(placeId);
    }

    state = newState;
  }

  bool isFavorite(String placeId) {
    return state.contains(placeId);
  }
}