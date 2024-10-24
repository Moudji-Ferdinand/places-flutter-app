import 'package:favourite_places/models/favourite_place.dart';
import 'package:favourite_places/providers/favourite_place_provider.dart';
import 'package:favourite_places/providers/favourite_places_provider.dart';
import 'package:favourite_places/screens/favourite_place_details.dart';
import 'package:favourite_places/screens/new_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePlacesListScreen extends ConsumerStatefulWidget {
  const FavouritePlacesListScreen({super.key});

  @override
  ConsumerState<FavouritePlacesListScreen> createState() =>
      _FavouritePlacesListScreenState();
}

class _FavouritePlacesListScreenState
    extends ConsumerState<FavouritePlacesListScreen> {
  List<FavouritePlace> _favouritePlaces = [];

  void _addNewPlace() {
    Navigator.of(context).push<FavouritePlace>(
      MaterialPageRoute(
        builder: (ctx) => const NewPlace(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No places added yet.',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );

    _favouritePlaces = ref.watch(favouritePlacesProvider);

    if (_favouritePlaces.isNotEmpty) {
      content = ListView.builder(
        itemCount: _favouritePlaces.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_favouritePlaces[index].id),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          ),
          onDismissed: (direction) {},
          child: ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(_favouritePlaces[index].image),
            ),
            onTap: () {
              ref.read(favouritePlaceProvider.notifier).changeFavouritePlace(
                    _favouritePlaces[index],
                  );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const FavouritePlaceDetails(),
                ),
              );
            },
            title: Text(
              _favouritePlaces[index].title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _addNewPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: content,
      ),
    );
  }
}
