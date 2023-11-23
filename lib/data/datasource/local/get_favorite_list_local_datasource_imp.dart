import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_library/data/datasource/get_favorite_list_datasource.dart';
import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/shared/utils/book_utils.dart';

class GetFavoriteListLocalDatasourceImp implements GetFavoriteListDatasource {
  final _sharedPreferences = SharedPreferences.getInstance();

  @override
  Future<List<Book>> call() async {
    final sharedPreferences = await _sharedPreferences;

    final favoriteListJson = sharedPreferences.getString('favoriteList');

    List<Book> favoriteList = [];
    favoriteList.fromJson(favoriteListJson ?? "");

    return favoriteList;
  }
}
