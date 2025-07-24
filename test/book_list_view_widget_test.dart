import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_developer_assignment/views/book_list_view.dart';
import 'package:flutter_developer_assignment/repository/book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_developer_assignment/blocs/book_bloc.dart';
import 'package:flutter_developer_assignment/blocs/book_event.dart';

import 'package:flutter_developer_assignment/models/book_model.dart';

// AI Generated - Sample books for testing
final dummyBooks = [
  Book(
    title: 'Flutter for Beginners',
    author: 'John Doe',
    publishedYear: 2021,
    genre: 'Programming',
    coverUrl: 'https://example.com/flutter.jpg',
  ),
  Book(
    title: 'Advanced Dart',
    author: 'Jane Smith',
    publishedYear: 2022,
    genre: 'Programming',
    coverUrl: 'https://example.com/dart.jpg',
  ),
];

class MockBookRepository extends BookRepository {
  @override
  Future<List<Book>> fetchBooks() async {
    return dummyBooks;
  }
}
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BookListPage Widget', () {
    testWidgets('shows loading indicator, then displays book list', (WidgetTester tester) async {
      final repository = MockBookRepository();
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => BookBloc(repository)..add(LoadBooks()),
            child: const BookListPage(),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
      expect(find.text('Flutter for Beginners'), findsOneWidget);
    });
  });
}
