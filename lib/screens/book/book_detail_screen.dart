import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/books_datasource.dart';
import 'package:flutter_application_1/entities/book.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});
  static const String name = "BookDetailScreen";

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  String _text = '';
  @override
  void initState() {
    super.initState();
    fetchText();
  }

  Future<void> fetchText() async {
    try {
      final text = await BooksDataSource.fetchText(widget.book.text);
      setState(() {
        _text = text;
      });
    } catch (e) {
      //catch
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.book.title,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: _text.isNotEmpty
              ? SelectableText(
                  _text,
                  style: const TextStyle(
                    fontSize: 19.0,
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
