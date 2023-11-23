import 'package:virtual_library/models/book.dart';

abstract class GetFavoriteListDatasource {
  Future<List<Book>> call();
}
