import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/book_bloc.dart';
import '../blocs/book_state.dart';
import '../blocs/book_event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'book_detail_view.dart';
import 'admin_page.dart';

class BookListPage extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeModeNotifier;
  const BookListPage({super.key, this.themeModeNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        actions: [
          SafeArea(
            child: Row(
              children: [
                if (themeModeNotifier != null)
                  ValueListenableBuilder<ThemeMode>(
                    valueListenable: themeModeNotifier!,
                    builder: (context, mode, _) {
                      return IconButton(
                        icon: Icon(mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
                        tooltip: mode == ThemeMode.dark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                        onPressed: () {
                          themeModeNotifier!.value =
                            mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BookBloc>().add(LoadBooks());
                await Future.delayed(const Duration(seconds: 2));
              },
              child: ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailPage(book: book),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      elevation: 2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: book.coverUrl,
                              placeholder: (context, url) => const SizedBox(
                                width: 60,
                                height: 90,
                                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              width: 60,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(book.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(book.author, style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is BookError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminPage()),
            );
          },
          tooltip: 'Admin',
          child: const Icon(Icons.admin_panel_settings),
        ),
      ),
    );
  }
}
