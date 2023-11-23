import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_library/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_library/shared/constants/book_api_constants.dart';

class BookRepository {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse(BookAPIConstants.getBooksURL));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Book.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load books');
    }
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
