import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/shared/themes/virtual_library_colors.dart';
import 'package:virtual_library/shared/themes/virtual_library_textstyles.dart';
import 'package:virtual_library/shared/widgets/book_item/book_item_bloc.dart';
import 'package:virtual_library/shared/widgets/book_item/book_item_states.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookItem extends StatefulWidget {
  final Book book;
  final VoidCallback onFavoriteIconPressed;

  const BookItem(
      {Key? key, required this.book, required this.onFavoriteIconPressed})
      : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  final _bookItemBloc = BookItemBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: GestureDetector(
            onTap: openBook,
            child: SizedBox(
              height: 90,
              width: 90,
              child: Image.network(
                widget.book.coverUrl ?? "",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            widget.book.title ?? "",
            textAlign: TextAlign.center,
            style: VirtualLibraryTextStyles.bookItemTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            widget.book.author ?? "",
            textAlign: TextAlign.center,
            style: VirtualLibraryTextStyles.bookItemAuthor,
          ),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    _bookItemBloc.downloadBookStream.listen((state) async {
      if (state is BookItemDownloadSuccess) {
        _bookItemBloc.openBook(widget.book.id);
      } else if (state is BookItemDownloadError) {
        await showToast('Error: ${state.message}', Colors.red);
      } else if (state is BookItemDownloadLoading) {
        await showToast("Downloading book... ${state.progress.toString()}%",
            VirtualLibraryColors.appPrimaryColor);
      }
    });
    super.didChangeDependencies();
  }

  Future<bool?> showToast(String msg, Color backgroundColor) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void openBook() {
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "book-${widget.book.id}",
      nightMode: true,
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      enableTts: true,
    );

    _bookItemBloc.executeBookDownload(widget.book);
  }

  @override
  void dispose() {
    _bookItemBloc.dispose();
    super.dispose();
  }
}
