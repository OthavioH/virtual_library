import 'dart:async';

import 'package:virtual_library/data/repository/favorites/favorites_repository.dart';
import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/data/repository/book/book_repository.dart';
import 'package:virtual_library/features/home/home_states.dart';

class HomeBloc {
  final BookRepository _bookRepository = BookRepository();
  final _favoritesRepository = FavoritesRepository();

  final _getBookListStreamController = StreamController<HomeState>.broadcast();

  Stream<HomeState> get getBookListStream =>
      _getBookListStreamController.stream;
  Sink<HomeState> get _getBookListSink => _getBookListStreamController.sink;

  HomeState _lastState = LoadingHomeState();

  HomeBloc() {
    getBookListStream.listen((event) {
      _lastState = event;
    });
  }

  void getBookList() async {
    _getBookListSink.add(LoadingHomeState());
    try {
      final List<Book> bookList = await _bookRepository.getBooks();
      _getBookListSink.add(SuccessHomeState(bookList: bookList));
    } catch (e) {
      _getBookListSink.add(ErrorHomeState(message: e.toString()));
    }
  }

  Future<void> handleToggleBookFavorite(Book book) async {
    await _favoritesRepository.toggleBookFromFavorites(book);

    replaceBookList(book.id);
  }

  void replaceBookList(int? bookId) {
    if (_lastState is SuccessHomeState) {
      final currentBookList = (_lastState as SuccessHomeState).bookList;

      final newBookList = currentBookList.map((book) {
        if (book.id == bookId) {
          return book.copyWith(isFavorite: book.isFavorite);
        } else {
          return book;
        }
      }).toList();

      _getBookListSink.add(SuccessHomeState(bookList: newBookList));
    }
  }

  void dispose() {
    _getBookListStreamController.close();
  }
}
