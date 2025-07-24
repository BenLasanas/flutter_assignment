
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_developer_assignment/repository/book_repository.dart';
import 'package:flutter_developer_assignment/models/book_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BookRepository', () {
    late BookRepository repository;

    setUp(() {
      repository = BookRepository();
    });

    test('loads books from JSON', () async {
      final books = await repository.fetchBooks();
      expect(books.isNotEmpty, true);
      expect(books.first, isA<Book>());
    });

    test('adds a book', () async {
      final initialBooks = await repository.fetchBooks();
      final newBook = Book(
        title: 'Test Book',
        author: 'Test Author',
        publishedYear: 2025,
        genre: 'Test',
        coverUrl: 'https://example.com/test.jpg',
      );
      await repository.addBook(newBook);
      final books = await repository.fetchBooks();
      expect(books.length, initialBooks.length + 1);
      expect(books.last.title, 'Test Book');
    });

    test('edits a book', () async {
      final books = await repository.fetchBooks();
      final book = books.first;
      final editedBook = book.copyWith(title: 'Edited Title');
      await repository.editBook(editedBook);
      final updatedBooks = await repository.fetchBooks();
      expect(updatedBooks.first.title, 'Edited Title');
    });

    test('deletes a book', () async {
      final books = await repository.fetchBooks();
      final book = books.first;
      await repository.deleteBook(book);
      final updatedBooks = await repository.fetchBooks();
      expect(updatedBooks.length, books.length - 1);
      expect(updatedBooks.contains(book), false);
    });
  });
}
