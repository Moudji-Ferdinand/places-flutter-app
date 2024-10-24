import 'package:favourite_places/providers/favourite_place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePlaceDetails extends ConsumerStatefulWidget {
  const FavouritePlaceDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FavouritePlaceDetails();
  }
}

class _FavouritePlaceDetails extends ConsumerState<FavouritePlaceDetails> {
  @override
  Widget build(BuildContext context) {
    final place = ref.watch(favouritePlaceProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          ],
        ));
  }
}
