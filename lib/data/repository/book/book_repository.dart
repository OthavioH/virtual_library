import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_library/data/repository/favorites/favorites_repository.dart';
import 'package:virtual_library/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_library/shared/constants/book_api_constants.dart';

class BookRepository {
  final _favoritesRepository = FavoritesRepository();

  final _sharedPreferences = SharedPreferences.getInstance();

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse(BookAPIConstants.getBooksURL));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final bookList = jsonResponse.map((e) => Book.fromMap(e)).toList();
      if (await _hasFavorites()) {
        final favorites = await _getFavoriteList();
        return _mergeWithFavorites(bookList, favorites);
      }
      return bookList;
    } else {
      throw Exception('Failed to load books');
    }
  }

  List<Book> _mergeWithFavorites(List<Book> books, List<Book> favorites) {
    for (var book in books) {
      final favorite = favorites.firstWhere(
        (element) => element.id == book.id,
        orElse: () => Book(),
      );

      book.isFavorite = favorite.id != null;
    }

    return books;
  }

  Future<List<Book>> _getFavoriteList() async {
    return await _favoritesRepository.getFavorites();
  }

  Future<bool> _hasFavorites() async {
    final favorites = await _favoritesRepository.getFavorites();

    return favorites.isNotEmpty;
  }

  Future<void> saveBookPath(int? bookId, String bookPath) async {
    final sp = await _sharedPreferences;

    sp.setString("$bookId-Download", bookPath);
  }

  Future<String?> getBookPath(int? bookId) async {
    final sp = await _sharedPreferences;

    return sp.getString("$bookId-Download");
  }
}
