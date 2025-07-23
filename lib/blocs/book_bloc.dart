import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/book_repository.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;
  BookBloc(this.repository) : super(BookInitial()) {
    on<LoadBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await repository.fetchBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError('Failed to load books'));
      }
    });
  }
}
