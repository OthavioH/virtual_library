import 'dart:convert';

import 'package:virtual_library/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_library/shared/constants/book_api_constants.dart';

class BookRepository {
  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse(BookAPIConstants.getBooksURL));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((dynamic book) => Book.fromMap(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
