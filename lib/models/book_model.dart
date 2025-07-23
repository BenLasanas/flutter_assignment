class Book {
  final String title;
  final String author;
  final String coverUrl;

  Book({required this.title, required this.author, required this.coverUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      author: json['author'] as String,
      coverUrl: json['coverUrl'] as String,
    );
  }
}
