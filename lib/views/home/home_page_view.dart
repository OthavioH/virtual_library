import 'package:flutter/material.dart';
import 'package:virtual_library/views/home/home_bloc.dart';
import 'package:virtual_library/views/home/home_states.dart';

import 'package:flutter/material.dart';
import 'package:virtual_library/views/home/home_bloc.dart';
import 'package:virtual_library/views/home/home_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Library')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => _bloc.getBookList(),
              child: const Text('Try Again'),
            ),
          ),
          Expanded(
            child: StreamBuilder<HomeState>(
              stream: _bloc.getBookListStream,
              builder:
                  (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
                if (snapshot.data is SuccessHomeState) {
                  final bookList = (snapshot.data as SuccessHomeState).bookList;
                  return ListView.builder(
                    itemCount: bookList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final book = bookList[index];
                      return ListTile(
                        key: Key(book.id.toString()),
                        title: Text(book.title ?? ""),
                        subtitle: Text(book.author ?? ""),
                      );
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
          )
        ],
      ),
    );
  }
}
