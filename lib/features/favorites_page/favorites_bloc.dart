import 'dart:async';

import 'package:virtual_library/data/repository/favorites/favorites_repository.dart';
import 'package:virtual_library/features/favorites_page/favorites_states.dart';
import 'package:virtual_library/models/book.dart';

class FavoritesBloc {
  final _favoritesRepository = FavoritesRepository();

  final _getFavoritesController = StreamController<FavoritesState>();

  Stream<FavoritesState> get getFavoritesStream =>
      _getFavoritesController.stream;

  Sink<FavoritesState> get _getFavoritesSink => _getFavoritesController.sink;

  Future<void> getFavorites() async {
    _getFavoritesSink.add(LoadingFavoritesState());
    try {
      final favorites = await _favoritesRepository.getFavorites();
      _getFavoritesSink.add(SuccessFavoritesState(favorites));
    } catch (e) {
      _getFavoritesSink.add(ErrorFavoritesState(e.toString()));
    }
  }

  Future<void> removeBookFromFavorite(Book bookToRemove) async {
    final newFavoritesList =
        await _favoritesRepository.toggleBookFromFavorites(bookToRemove);

    _getFavoritesSink.add(SuccessFavoritesState(newFavoritesList));
  }

  void dispose() {
    _getFavoritesController.close();
  }
}
