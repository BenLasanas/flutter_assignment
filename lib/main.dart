import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/book_repository.dart';
import 'blocs/book_bloc.dart';
import 'blocs/book_event.dart';
import 'views/book_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookBloc(BookRepository())..add(LoadBooks()),
      child: MaterialApp(
        title: 'Book List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const BookListPage(),
      ),
    );
  }
}
