import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/book_repository.dart';
import '../models/book_model.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;
  BookBloc(this.repository) : super(BookInitial()) {
    on<LoadBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await repository.fetchBooks();
        emit(BookLoaded(List<Book>.from(books)));
      } catch (e) {
        emit(BookError('Failed to load books'));
      }
    });

    on<AddBook>((event, emit) async {
      if (state is BookLoaded) {
        final books = List<Book>.from((state as BookLoaded).books);
        emit(BookLoading());
        await Future.delayed(const Duration(seconds: 2));
        books.add(event.book);
        emit(BookLoaded(books));
      }
    });

    on<EditBook>((event, emit) async {
      if (state is BookLoaded) {
        final books = List<Book>.from((state as BookLoaded).books);
        emit(BookLoading());
        await Future.delayed(const Duration(seconds: 2)); 
        if (event.index >= 0 && event.index < books.length) {
          books[event.index] = event.book;
          emit(BookLoaded(books));
        }
      }
    });

    on<DeleteBook>((event, emit) async {
      if (state is BookLoaded) {
        final books = List<Book>.from((state as BookLoaded).books);
        emit(BookLoading());
        await Future.delayed(const Duration(seconds: 2)); 
        if (event.index >= 0 && event.index < books.length) {
          books.removeAt(event.index);
          emit(BookLoaded(books));
        }
      }
    });
  }
}
