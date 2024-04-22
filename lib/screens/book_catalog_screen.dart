import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/book.dart';
import 'package:flutter_application_1/core/data/books_datasource.dart';
import 'package:flutter_application_1/screens/book_detail_screen.dart';
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
      final books = await BooksDataSource.fetchBooks(widget.lang);
      setState(() {
        _books = books;
      });
    } catch (e) {
      print('Error fetching books: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching books')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Libros',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
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
        return Card(
          child: ListTile(
            title:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                book.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              Image.network(book.image),
            ]),
            onTap: () {
              context.pushNamed(BookDetailScreen.name, extra: book);
            },
          ),
        );
      },
    );
  }
}
