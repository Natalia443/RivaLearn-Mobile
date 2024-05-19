import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/flashcard_provider.dart';
import 'package:flutter_application_1/screens/flashcard/flashcard_creator_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FlashcardScreen extends ConsumerWidget {
  final String deckname;
  const FlashcardScreen({super.key, required this.deckname});
  static const String name = "FlashcardScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashcardState = ref.watch(flashcardProvider(deckname));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: RefreshIndicator(
          onRefresh: () => ref.refresh(flashcardProvider(deckname).future),
          child: flashcardState.when(
            data: (flashcardList) {
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
            },
            error: (error, _) => Center(
              child: Text('Error: $error'),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          )),
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
