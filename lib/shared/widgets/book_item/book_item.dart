import 'dart:ui';

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
    return GestureDetector(
      onTap: openBook,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _BookItemBackgroundImage(bookCoverURL: widget.book.coverUrl ?? ""),
            Positioned(
              bottom: 20,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 170),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title ?? "",
                        textAlign: TextAlign.start,
                        style: VirtualLibraryTextStyles.bookItemTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.book.author ?? "",
                        textAlign: TextAlign.start,
                        style: VirtualLibraryTextStyles.bookItemAuthor,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: widget.onFavoriteIconPressed,
                child: Icon(
                  widget.book.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: VirtualLibraryColors.favoriteIconColor,
                ),
              ),
            ),
          ],
        ),
      ),
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

class _BookItemBackgroundImage extends StatelessWidget {
  final String bookCoverURL;
  const _BookItemBackgroundImage({
    Key? key,
    required this.bookCoverURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(bookCoverURL),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaX: 1, sigmaY: 1, tileMode: TileMode.decal),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
