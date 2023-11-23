import 'package:virtual_library/data/datasource/add_favorite_datasource.dart';
import 'package:virtual_library/data/datasource/get_favorite_list_datasource.dart';
import 'package:virtual_library/models/book.dart';

class FavoritesRepository {
  final AddFavoriteDatasource _addFavoriteDatasource;
  final GetFavoriteListDatasource _getFavoriteListDatasource;

  FavoritesRepository(
      this._getFavoriteListDatasource, this._addFavoriteDatasource);

  Future<List<Book>> getFavorites() async {
    return await _getFavoriteListDatasource();
  }

  Future<void> addFavorite(Book book) async {
    await _addFavoriteDatasource(book);
  }
}
