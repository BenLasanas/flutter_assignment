import 'package:flutter/material.dart';
import '../models/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class BookDetailPage extends StatelessWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Container(
        color: theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: book.coverUrl,
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    width: 120,
                    height: 180,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 120),
                ),
              ),
              const SizedBox(height: 24),
              Text('Title: ${book.title}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 8),
              Text('Author: ${book.author}', style: TextStyle(fontSize: 16, color: textColor)),
              const SizedBox(height: 8),
              Text('Published Year: ${book.publishedYear}', style: TextStyle(fontSize: 16, color: textColor)),
              const SizedBox(height: 8),
              Text('Genre: ${book.genre}', style: TextStyle(fontSize: 16, color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
