import 'dart:io';

class FavouritePlace {
  const FavouritePlace(
      {required this.id, required this.title, required this.image});

  final String id;
  final String title;
  final File image;
}
