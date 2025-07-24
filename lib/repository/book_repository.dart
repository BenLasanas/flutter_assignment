import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/book_model.dart';

class BookRepository {
  Future<List<Book>> fetchBooks() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    final String response = await rootBundle.loadString('assets/books.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Book.fromJson(json)).toList();
  }
}
