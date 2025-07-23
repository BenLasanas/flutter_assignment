import 'package:flutter/material.dart';
import '../models/book_model.dart';


class BookDetailPage extends StatelessWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                book.coverUrl,
                width: 120,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 120),
              ),
            ),
            const SizedBox(height: 24),
            Text('Title: ${book.title}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Author: ${book.author}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Published Year: ${book.publishedYear}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Genre: ${book.genre}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
