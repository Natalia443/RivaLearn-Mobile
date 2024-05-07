import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/flashcard_datasource.dart';
import 'package:flutter_application_1/screens/flashcard/flashcard_creator_screen.dart';
import 'package:go_router/go_router.dart';

class FlashcardScreen extends StatelessWidget {
  final String deckname;
  const FlashcardScreen({super.key, required this.deckname});
  static const String name = "FlashcardScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getFlashcards(deckname),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final flashcardList = snapshot.data!;
            return ListView.builder(
              itemCount: flashcardList.length,
              itemBuilder: (context, index) {
                final flashcardName = flashcardList[index]['vocab'] as String;
                return Card(
                    child: ListTile(
                  title: Text(flashcardName),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ));
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(FlashcardCreatorScreen.name, extra: deckname);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
