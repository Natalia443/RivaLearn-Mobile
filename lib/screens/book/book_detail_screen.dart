import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/books_datasource.dart';

class BookDetailScreen extends StatefulWidget {
  final Map<String, dynamic> book;
  const BookDetailScreen({super.key, required this.book});
  static const String name = "BookDetailScreen";

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late TextEditingController _textController;
  bool _isLoading = true;

  void _showDialog(BuildContext context) {
    Navigator.of(context).push(
      DialogRoute<void>(
        context: context,
        builder: (BuildContext context) =>
            const AlertDialog(title: Text('Test')),
      ),
    );
  }

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
      final textUrl = widget.book['formats']?['text/plain; charset=us-ascii'];
      if (textUrl != null) {
        final text = await fetchText(textUrl);
        setState(() {
          _textController.text = text;
          _isLoading = false;
        });
      } else {
        setState(() {
          _textController.text = 'No text available for this book';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching book text: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching book text')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book['title'] ?? 'Text',
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
                  final List<ContextMenuButtonItem> buttonItems =
                      editableTextState.contextMenuButtonItems;
                  buttonItems.insert(
                    0,
                    ContextMenuButtonItem(
                      label: 'Crear Flashcard',
                      onPressed: () {
                        ContextMenuController.removeAny();
                        _showDialog(context);
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
