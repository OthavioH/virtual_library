import 'package:flutter/material.dart';
import 'package:virtual_library/features/favorites_page/favorites_bloc.dart';
import 'package:virtual_library/features/favorites_page/favorites_states.dart';
import 'package:virtual_library/shared/widgets/book_item/book_item.dart';
import 'package:virtual_library/shared/widgets/empty_favorite_list/empty_favorite_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _bloc = FavoritesBloc();

  @override
  void initState() {
    _bloc.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: StreamBuilder<FavoritesState>(
        stream: _bloc.getFavoritesStream,
        builder:
            (BuildContext context, AsyncSnapshot<FavoritesState> snapshot) {
          if (snapshot.data is SuccessFavoritesState) {
            final favoriteBookList =
                (snapshot.data as SuccessFavoritesState).favoriteBookList;
            return favoriteBookList.isEmpty
                ? const EmptyFavoriteList()
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    shrinkWrap: true,
                    itemCount: favoriteBookList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BookItem(
                        book: favoriteBookList[index],
                        onFavoriteIconPressed: () async {
                          await _bloc
                              .removeBookFromFavorite(favoriteBookList[index]);
                        },
                      );
                    },
                  );
          } else if (snapshot.data is ErrorFavoritesState) {
            final message = (snapshot.data as ErrorFavoritesState).message;
            return Center(child: Text(message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
