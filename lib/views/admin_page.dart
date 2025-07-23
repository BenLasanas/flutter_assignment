import 'package:flutter/material.dart';
import '../models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/book_bloc.dart';
import '../blocs/book_event.dart';
import '../blocs/book_state.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  void _showBookDialog({Book? book, int? index}) {
    final titleController = TextEditingController(text: book?.title ?? '');
    final authorController = TextEditingController(text: book?.author ?? '');
    final yearController = TextEditingController(text: book?.publishedYear.toString() ?? '');
    final genreController = TextEditingController(text: book?.genre ?? '');
    final coverController = TextEditingController(text: book?.coverUrl ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(book == null ? 'Add Book' : 'Edit Book'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
                TextField(controller: authorController, decoration: const InputDecoration(labelText: 'Author')),
                TextField(controller: yearController, decoration: const InputDecoration(labelText: 'Published Year'), keyboardType: TextInputType.number),
                TextField(controller: genreController, decoration: const InputDecoration(labelText: 'Genre')),
                TextField(controller: coverController, decoration: const InputDecoration(labelText: 'Cover Image URL')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final newBook = Book(
                  title: titleController.text,
                  author: authorController.text,
                  publishedYear: int.tryParse(yearController.text) ?? 0,
                  genre: genreController.text,
                  coverUrl: coverController.text,
                );
                if (book == null) {
                  context.read<BookBloc>().add(AddBook(newBook));
                } else if (index != null) {
                  context.read<BookBloc>().add(EditBook(index, newBook));
                }
                Navigator.pop(context);
              },
              child: Text(book == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Section')),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            final books = state.books;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: Image.network(book.coverUrl, width: 40, height: 60, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.error)),
                    title: Text(book.title),
                    subtitle: Text('${book.author} • ${book.publishedYear} • ${book.genre}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showBookDialog(book: book, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<BookBloc>().add(DeleteBook(index));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is BookError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBookDialog(),
        child: const Icon(Icons.add),
        tooltip: 'Add Book',
      ),
    );
  }
}
