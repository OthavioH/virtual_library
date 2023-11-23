import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_library/data/datasource/add_favorite_datasource.dart';
import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/shared/utils/book_utils.dart';

class AddFavoriteLocalDatasourceImp implements AddFavoriteDatasource {
  final _sharedPreferences = SharedPreferences.getInstance();

  @override
  Future<void> call(Book book) async {
    final sharedPreferences = await _sharedPreferences;

    final favoriteListJson = sharedPreferences.getString('favoriteList');

    List<Book> favoriteList = [];
    favoriteList.fromJson(favoriteListJson ?? "");

    favoriteList.add(book);

    await sharedPreferences.setString(
      'favoriteList',
      favoriteList.toJson(),
    );
  }
}
