import 'package:virtual_library/models/book.dart';

abstract class AddFavoriteDatasource {
  Future<void> call(Book book);
}
