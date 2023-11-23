import 'dart:async';

import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_library/models/book.dart';
import 'package:virtual_library/shared/utils/book_utils.dart';
import 'package:virtual_library/shared/widgets/book_item/book_item_states.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookItemBloc {
  final StreamController<BookItemDownloadState> _downloadBookController =
      StreamController<BookItemDownloadState>();

  Stream<BookItemDownloadState> get downloadBookStream =>
      _downloadBookController.stream;
  Sink<BookItemDownloadState> get _downloadBookSink =>
      _downloadBookController.sink;

  Future<void> executeBookDownload(Book book) async {
    final bookHasDownload = await verifyBookHasDownload(book.id);

    if (!bookHasDownload) {
      return await downloadEpubFile(book);
    }

    openBook(book.id);
  }

  void openBook(int? bookId) async {
    final bookPath = await getBookPath(bookId);
    openEpubFile(bookPath);
  }

  Future<bool> verifyBookHasDownload(int? bookId) async {
    final path = await getBookPath(bookId);

    return path != null;
  }

  Future<void> downloadEpubFile(Book book) async {
    await requestStoragePermission();
    _downloadBookSink.add(BookItemDownloadInitial());
    try {
      final bookTitle = book.title?.removeAnySpecialCharacters();
      final datetime = DateTime.now().microsecondsSinceEpoch;
      final filename = "$bookTitle-$datetime.epub";

      await FileDownloader.downloadFile(
        url: book.downloadUrl ?? "",
        name: filename,
        onProgress: (String? taskId, double progress) =>
            _downloadBookSink.add(BookItemDownloadLoading(progress)),
        onDownloadCompleted: (String path) async {
          _downloadBookSink.add(BookItemDownloadSuccess());
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("${book.id}-Download", path);
        },
        onDownloadError: (String error) =>
            _downloadBookSink.add(BookItemDownloadError(error)),
      );
    } catch (e) {
      _downloadBookSink.add(BookItemDownloadError(e.toString()));
    }
  }

  Future<void> requestStoragePermission() async {
    var storagePermission = Permission.storage;
    if (await storagePermission.status.isDenied) {
      await storagePermission.request();
    }
    return;
  }

  void openEpubFile(String pathToBook) {
    try {
      VocsyEpub.open(
        pathToBook,
      );
    } catch (e) {
      _downloadBookSink.add(BookItemDownloadError(e.toString()));
    }
  }

  void dispose() {
    _downloadBookController.close();
  }

  getBookPath(int? id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final path = preferences.getString("$id-Download");
    return path;
  }
}
