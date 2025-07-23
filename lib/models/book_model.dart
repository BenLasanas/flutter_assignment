class Book {
  final String title;
  final String author;
  final int publishedYear;
  final String genre;
  final String coverUrl;

  Book({
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.genre,
    required this.coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      author: json['author'] as String,
      publishedYear: json['publishedYear'] as int,
      genre: json['genre'] as String,
      coverUrl: json['coverUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publishedYear': publishedYear,
      'genre': genre,
      'coverUrl': coverUrl,
    };
  }
}
