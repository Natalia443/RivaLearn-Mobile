import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/books_datasource.dart';
import 'package:flutter_application_1/entities/entities.dart';
import 'package:flutter_application_1/screens/book/book_detail_screen.dart';
import 'package:go_router/go_router.dart';

class BookCatalogScreen extends StatefulWidget {
  final String lang;

  const BookCatalogScreen({super.key, required this.lang});

  static const String name = "BookCatalogScreen";

  @override
  State<BookCatalogScreen> createState() => _BookCatalogScreenState();
}

class _BookCatalogScreenState extends State<BookCatalogScreen> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    fetchLanguageBooks();
  }

  Future<void> fetchLanguageBooks() async {
    try {
      final books = await fetchBooks(widget.lang);
      setState(() {
        _books = books;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros'),
      ),
      body: _books.isNotEmpty
          ? BookViewer(books: _books)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class BookViewer extends StatelessWidget {
  const BookViewer({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _books.length < 10 ? _books.length : 10,
      itemBuilder: (context, index) {
        final book = _books[index];
        final title = book.title;
        final imageUrl = book.image ?? '';

        return Card(
          child: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title ?? "titulo",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10.0),
                imageUrl.isNotEmpty ? Image.network(imageUrl) : Container(),
              ],
            ),
            onTap: () {
              context.pushNamed(BookDetailScreen.name, extra: book);
            },
          ),
        );
      },
    );
  }
}
