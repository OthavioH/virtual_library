import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_library/models/book.dart';

class FavoritesRepository {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<List<Book>> getFavorites() async {
    return await _getFavoritesFromSharedPreferences();
  }

  Future<List<Book>> toggleBookFromFavorites(Book book) async {
    final favoritesList = await _getFavoritesFromSharedPreferences();

    if (book.isFavorite) {
      favoritesList.removeWhere((element) => element.id == book.id);
    } else {
      favoritesList.add(book);
    }

    await _editFavoriteList(favoritesList);
    return favoritesList;
  }

  Future<List<Book>> _getFavoritesFromSharedPreferences() async {
    final sp = await _sharedPreferences;
    final favorites = sp.getString('favorites');
    if (favorites != null) {
      final favoritesList = jsonDecode(favorites) as List;
      return favoritesList.map((e) => Book.fromMap(e)).toList();
    }

    return [];
  }

  Future<void> _editFavoriteList(List<Book> books) async {
    final sp = await _sharedPreferences;
    final encodedBooks = books.map((book) => book.toMap()).toList();
    sp.setString('favorites', jsonEncode(encodedBooks));
  }
}
