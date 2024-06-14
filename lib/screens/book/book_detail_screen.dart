import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/books_datasource.dart';
import 'package:flutter_application_1/entities/entities.dart';
import 'package:flutter_application_1/screens/book/deck_selection_screen.dart';
import 'package:go_router/go_router.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});
  static const String name = "BookDetailScreen";

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late TextEditingController _textController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    fetchBookText();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> fetchBookText() async {
    try {
      final textUrl = widget.book.text;
      String text;
      if (textUrl != null) {
        text = await fetchText(textUrl);
      } else {
        text = "El texto de este libro no se encuentra disponible";
      }
      setState(() {
        _textController.text = text;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book.title ?? "titulo",
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: SelectableText(
                _textController.text,
                contextMenuBuilder: (context, editableTextState) {
                  final TextEditingValue value =
                      editableTextState.textEditingValue;
                  final selectedWord = value.selection.textInside(value.text);

                  final List<ContextMenuButtonItem> buttonItems =
                      editableTextState.contextMenuButtonItems;
                  buttonItems.clear();
                  buttonItems.insert(
                    0,
                    ContextMenuButtonItem(
                      label: 'Crear Flashcard',
                      onPressed: () {
                        ContextMenuController.removeAny();
                        context.pushNamed(DeckSelectionScreen.name,
                            extra: selectedWord);
                      },
                    ),
                  );
                  return AdaptiveTextSelectionToolbar.buttonItems(
                    anchors: editableTextState.contextMenuAnchors,
                    buttonItems: buttonItems,
                  );
                },
                style: const TextStyle(
                  fontSize: 19.0,
                  color: Colors.black,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
    );
  }
}
