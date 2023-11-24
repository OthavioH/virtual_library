import 'dart:async';

import 'package:virtual_library/data/repository/favorites/favorites_repository.dart';
import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/data/repository/book/book_repository.dart';
import 'package:virtual_library/features/home/home_states.dart';

class HomeBloc {
  final BookRepository _bookRepository = BookRepository();
  final _favoritesRepository = FavoritesRepository();

  final _getBookListStreamController = StreamController<HomeState>();

  Stream<HomeState> get getBookListStream =>
      _getBookListStreamController.stream;
  Sink<HomeState> get _getBookListSink => _getBookListStreamController.sink;

  void getBookList() async {
    _getBookListSink.add(LoadingHomeState());
    try {
      final List<Book> bookList = await _bookRepository.getBooks();
      _getBookListSink.add(SuccessHomeState(bookList: bookList));
    } catch (e) {
      _getBookListSink.add(ErrorHomeState(message: e.toString()));
    }
  }

  Future<void> handleToggleBookFavorite(int? bookId, bool isFavorite) async {
    if (isFavorite) {
      await _favoritesRepository.addBookToFavorites(Book(id: bookId));
    } else {
      await _favoritesRepository.removeBookFromFavorites(bookId);
    }

    getBookList();
  }

  void dispose() {
    _getBookListStreamController.close();
  }
}
