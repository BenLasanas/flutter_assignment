import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_developer_assignment/blocs/book_bloc.dart';
import 'package:flutter_developer_assignment/blocs/book_event.dart';
import 'package:flutter_developer_assignment/blocs/book_state.dart';
import 'package:flutter_developer_assignment/repository/book_repository.dart';
import 'package:flutter_developer_assignment/models/book_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('BookBloc', () {
    late BookBloc bloc;
    late BookRepository repository;

    setUp(() {
      repository = BookRepository();
      bloc = BookBloc(repository);
    });

    test('emits BookLoading, BookLoadedwhen LoadBooks is added', () async {
      bloc.add(LoadBooks());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<BookLoading>(),
          isA<BookLoaded>(),
        ]),
      );
    });

    test('emits BookLoading, BookLoaded when AddBook is added', () async {
      await bloc.repository.fetchBooks();
      bloc.add(LoadBooks());
      await Future.delayed(const Duration(seconds: 3));
      final book = Book(
        title: 'Bloc Test',
        author: 'Tester',
        publishedYear: 2025,
        genre: 'Test',
        coverUrl: 'https://example.com/test.jpg',
      );
      bloc.add(AddBook(book));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<BookLoading>(),
          isA<BookLoaded>(),
        ]),
      );
    });

    test('emits BookLoading, BookLoaded when EditBook is added', () async {
      await bloc.repository.fetchBooks();
      bloc.add(LoadBooks());
      await Future.delayed(const Duration(seconds: 3));
      final books = await bloc.repository.fetchBooks();
      final book = books.first;
      final editedBook = book.copyWith(title: 'Bloc Edited');
      bloc.add(EditBook(0, editedBook));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<BookLoading>(),
          isA<BookLoaded>(),
        ]),
      );
    });

    test('emits BookLoading, BookLoaded when DeleteBook is added', () async {
      await bloc.repository.fetchBooks();
      bloc.add(LoadBooks());
      await Future.delayed(const Duration(seconds: 3));
      final books = await bloc.repository.fetchBooks();
      final book = books.first;
      bloc.add(DeleteBook(book));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<BookLoading>(),
          isA<BookLoaded>(),
        ]),
      );
    });
  });
}
