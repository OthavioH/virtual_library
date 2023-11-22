import 'dart:async';

import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/repository/book/book_repository.dart';
import 'package:virtual_library/features/home/home_states.dart';

class HomeBloc {
  final _bookRepository = BookRepository();

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

  void dispose() {
    _getBookListStreamController.close();
  }
}
