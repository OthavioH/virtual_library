

import 'package:virtual_library/models/book.dart';

abstract class HomeState {}

class LoadingHomeState extends HomeState {}

class SuccessHomeState extends HomeState {
  final List<Book> bookList;

  SuccessHomeState({required this.bookList});
}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState({required this.message});
}