import 'dart:convert';

import 'package:virtual_library/models/book.dart';

extension StringExtensions on String {
  String removeAnySpecialCharacters() {
    final textWithoutSpecialCharacters = replaceAll(RegExp(r'[^\w\s]+'), '');
    final textWithoutSpaces = textWithoutSpecialCharacters.replaceAll(' ', '-');
    return textWithoutSpaces;
  }
}

extension FavoriteListExtension on List<Book> {
  Map<String, dynamic> toMap() {
    return {
      'favoriteList': map((x) => x.toMap()).toList(),
    };
  }

  fromMap(Map<String, dynamic> map) {
    return List<Book>.from(map['favoriteList']?.map((x) => Book.fromMap(x)));
  }

  String toJson() => json.encode(toMap());

  fromJson(String source) => fromMap(json.decode(source));
}
