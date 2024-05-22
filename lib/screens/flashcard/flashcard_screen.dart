import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/flashcard_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/widgets.dart';

class FlashcardScreen extends ConsumerWidget {
  final String deckId;
  const FlashcardScreen({super.key, required this.deckId});
  static const String name = "FlashcardScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashcardState = ref.watch(flashcardProvider(deckId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
      ),
      body: RefreshIndicator(
          onRefresh: () => ref.refresh(flashcardProvider(deckId).future),
          child: flashcardState.when(
            data: (flashcardList) => ListView.builder(
              itemCount: flashcardList.length,
              itemBuilder: (context, index) {
                final flashcardName = flashcardList[index]['vocab'];
                return Card(
                  child: ListTile(
                    title: Text(flashcardName),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
            error: (error, _) => Center(
              child: Text('Error: $error'),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return PopScope(child: CreateFlashcardDialog(deckId: deckId));
              });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
