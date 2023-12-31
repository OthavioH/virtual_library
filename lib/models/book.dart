import 'dart:convert';

class Book {
  int? id;
  String? title;
  String? author;
  String? coverUrl;
  String? downloadUrl;
  bool isFavorite = false;

  Book({this.id, this.title, this.author, this.coverUrl, this.downloadUrl});

  factory Book.fromRawJson(String str) => Book.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  Book.fromMap(Map<String, dynamic> jsonToParse) {
    id = jsonToParse['id'];
    title = jsonToParse['title'];
    author = jsonToParse['author'];
    coverUrl = jsonToParse['cover_url'];
    downloadUrl = jsonToParse['download_url'];
    isFavorite = jsonToParse['is_favorite'] ?? false;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['cover_url'] = coverUrl;
    data['download_url'] = downloadUrl;
    data['is_favorite'] = isFavorite;
    return data;
  }

  Book copyWith({
    String? title,
    String? author,
    String? coverUrl,
    String? downloadUrl,
    bool? isFavorite,
  }) {
    this.title = title ?? this.title;
    this.author = author ?? this.author;
    this.coverUrl = coverUrl ?? this.coverUrl;
    this.downloadUrl = downloadUrl ?? this.downloadUrl;
    this.isFavorite = isFavorite ?? this.isFavorite;

    return this;
  }
}
