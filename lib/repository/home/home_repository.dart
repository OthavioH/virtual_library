
import 'dart:convert';

import 'package:virtual_library/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_library/models/book_list.dart';
import 'package:virtual_library/shared/constants/book_api_constants.dart';

class HomeRepository {
  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse(BookAPIConstants.getBooksURL));
    if (response.statusCode == 200) {
      final convertedJSON = jsonDecode(response.body);
      print(convertedJSON);
      return BookList.fromJson(convertedJSON).bookList!;
    } else {
      throw Exception('Failed to load books');
    }
  }
}