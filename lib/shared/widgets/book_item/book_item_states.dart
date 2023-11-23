abstract class BookItemDownloadState {}

class BookItemDownloadInitial extends BookItemDownloadState {}

class BookItemDownloadLoading extends BookItemDownloadState {
  final double progress;

  BookItemDownloadLoading(this.progress);
}

class BookItemDownloadSuccess extends BookItemDownloadState {}

class BookItemDownloadError extends BookItemDownloadState {
  final String message;

  BookItemDownloadError(this.message);
}
