
import 'package:virtual_library/models/book.dart';

class BookList {
  List<Book>? bookList;

  BookList({required this.bookList});

  // crate from json and toJson

  BookList.fromJson(List<Map<String, dynamic>> jsonToParse) {
    bookList = jsonToParse.map((bookJson) => Book.fromJson(bookJson)).toList();
  }
}