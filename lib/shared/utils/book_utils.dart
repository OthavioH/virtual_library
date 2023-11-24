import 'package:virtual_library/models/book.dart';

extension StringExtensions on String {
  String removeAnySpecialCharacters() {
    final textWithoutSpecialCharacters = replaceAll(RegExp(r'[^\w\s]+'), '');
    final textWithoutSpaces = textWithoutSpecialCharacters.replaceAll(' ', '-');
    return textWithoutSpaces;
  }
}

extension BookListExtensions on List<Book> {
  removeBooksWithDuplicatedIDs() {
    // remove duplicated books comparing the ids
    final uniqueBookList = <Book>[];
    for (var book in this) {
      if (!uniqueBookList.any((element) => element.id == book.id)) {
        uniqueBookList.add(book);
      }
    }
    return uniqueBookList;
  }
}
