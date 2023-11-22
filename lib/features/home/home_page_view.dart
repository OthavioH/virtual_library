import 'package:flutter/material.dart';
import 'package:virtual_library/features/home/home_bloc.dart';
import 'package:virtual_library/features/home/home_states.dart';
import 'package:virtual_library/shared/widgets/book_item/book_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeBloc();

  @override
  void initState() {
    _bloc.getBookList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: StreamBuilder<HomeState>(
        stream: _bloc.getBookListStream,
        builder: (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
          if (snapshot.data is SuccessHomeState) {
            final bookList = (snapshot.data as SuccessHomeState).bookList;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
              ),
              shrinkWrap: true,
              itemCount: bookList.length,
              itemBuilder: (BuildContext context, int index) {
                return BookItem(book: bookList[index]);
              },
            );
          } else if (snapshot.data is ErrorHomeState) {
            final message = (snapshot.data as ErrorHomeState).message;
            return Center(child: Text(message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
