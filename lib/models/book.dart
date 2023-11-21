
import 'dart:convert';

class Book {
  int? id;
  String? title;
  String? author;
  String? coverUrl;
  String? downloadUrl;

  Book({this.id, this.title, this.author, this.coverUrl, this.downloadUrl});

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Book.fromJson(Map<String, dynamic> jsonToParse) {
    id = jsonToParse['id'];
    title = jsonToParse['title'];
    author = jsonToParse['author'];
    coverUrl = jsonToParse['cover_url'];
    downloadUrl = jsonToParse['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['cover_url'] = coverUrl;
    data['download_url'] = downloadUrl;
    return data;
  }
}