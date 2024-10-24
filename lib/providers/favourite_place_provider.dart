import 'dart:io';

import 'package:favourite_places/models/favourite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePlaceNotifier extends StateNotifier<FavouritePlace> {
  FavouritePlaceNotifier()
      : super(
          FavouritePlace(id: '', title: '', image: File('')),
        );

  void changeFavouritePlace(FavouritePlace place) {
    state = place;
  }
}

final favouritePlaceProvider =
    StateNotifierProvider<FavouritePlaceNotifier, FavouritePlace>((ref) {
  return FavouritePlaceNotifier();
});
