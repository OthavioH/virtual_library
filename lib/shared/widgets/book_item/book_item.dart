import 'package:flutter/material.dart';
import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/shared/themes/virtual_library_textstyles.dart';

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
              book.coverUrl ?? "",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Text(
          book.title ?? "",
          textAlign: TextAlign.center,
          style: VirtualLibraryTextStyles.bookItemTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(book.author ?? "",
            textAlign: TextAlign.center,
            style: VirtualLibraryTextStyles.bookItemAuthor)
      ],
    );
  }
}
