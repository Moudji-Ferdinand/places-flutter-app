import 'package:favourite_places/models/favourite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePlacesNotifier extends StateNotifier<List<FavouritePlace>> {
  FavouritePlacesNotifier() : super([]);

  // this method enables us to add or remove places from the list
  void toggleFavouritePlace(FavouritePlace place) {
    // Check is place is part of the list
    final placeIsFound = state.contains(place);

    if (placeIsFound) {
      state = state.where((pl) => pl.id != place.id).toList();
    } else {
      state = [place, ...state];
    }
  }
}

final favouritePlacesProvider =
    StateNotifierProvider<FavouritePlacesNotifier, List<FavouritePlace>>((ref) {
  return FavouritePlacesNotifier();
});
