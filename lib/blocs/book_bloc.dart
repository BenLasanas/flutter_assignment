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
      emit(BookLoading());
      await repository.addBook(event.book);
      final books = await repository.fetchBooks();
      emit(BookLoaded(List<Book>.from(books)));
    });

    on<EditBook>((event, emit) async {
      emit(BookLoading());
      await repository.editBook(event.book);
      final books = await repository.fetchBooks();
      emit(BookLoaded(List<Book>.from(books)));
    });

    on<DeleteBook>((event, emit) async {
      emit(BookLoading());
      await repository.deleteBook(event.book);
      final books = await repository.fetchBooks();
      emit(BookLoaded(List<Book>.from(books)));
    });
  }
}
