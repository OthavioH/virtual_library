import 'dart:async';

import 'package:virtual_library/data/repository/favorites/favorites_repository.dart';
import 'package:virtual_library/features/favorites_page/favorites_states.dart';

class FavoritesBloc {
  final _favoritesRepository = FavoritesRepository();

  final _favoritesController = StreamController<FavoritesState>();

  Stream<FavoritesState> get favoritesStream => _favoritesController.stream;

  Future<void> getFavorites() async {
    _favoritesController.add(LoadingFavoritesState());
    try {
      final favorites = await _favoritesRepository.getFavorites();
      _favoritesController.add(SuccessFavoritesState(favorites));
    } catch (e) {
      _favoritesController.add(ErrorFavoritesState(e.toString()));
    }
  }
}
