import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/book_model.dart';


class BookRepository {
  List<Book> _books = [];

  Future<List<Book>> fetchBooks() async {
    await Future.delayed(const Duration(seconds: 2)); 
    if (_books.isEmpty) {
      final String response = await rootBundle.loadString('assets/books.json');
      final List<dynamic> data = json.decode(response);
      _books = data.map((json) => Book.fromJson(json)).toList();
    }
    return List<Book>.from(_books);
  }

  Future<void> addBook(Book book) async {
    await Future.delayed(const Duration(seconds: 1));
    _books.add(book);
  }

  Future<void> editBook(Book editedBook) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _books.indexWhere((b) => b.author == editedBook.author && b.publishedYear == editedBook.publishedYear);
    if (index != -1) {
      _books[index] = editedBook;
    }
  }

  Future<void> deleteBook(Book book) async {
    await Future.delayed(const Duration(seconds: 1));
    _books.removeWhere((b) => b.title == book.title && b.author == book.author);
  }
}
