import 'package:virtual_library/models/book.dart';

abstract class FavoritesState {}

class LoadingFavoritesState extends FavoritesState {}

class SuccessFavoritesState extends FavoritesState {
  final List<Book> favoriteBookList;

  SuccessFavoritesState(this.favoriteBookList);
}

class ErrorFavoritesState extends FavoritesState {
  final String message;

  ErrorFavoritesState(this.message);
}
