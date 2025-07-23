import '../models/book_model.dart';

abstract class BookEvent {}
class LoadBooks extends BookEvent {}
class AddBook extends BookEvent {
  final Book book;
  AddBook(this.book);
}
class EditBook extends BookEvent {
  final int index;
  final Book book;
  EditBook(this.index, this.book);
}
class DeleteBook extends BookEvent {
  final int index;
  DeleteBook(this.index);
}
