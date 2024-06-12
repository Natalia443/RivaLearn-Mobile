import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/deck.dart';
import 'package:flutter_application_1/providers/flashcard_provider.dart';
import 'package:flutter_application_1/providers/stories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiStoriesScreen extends ConsumerStatefulWidget {
  static const String name = "AiStoriesScreen";
  final Deck deck;
  const AiStoriesScreen({super.key, required this.deck});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AiStoriesScreenState();
}

class _AiStoriesScreenState extends ConsumerState<AiStoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final flashcardState =
        ref.watch(flashcardProvider(widget.deck.deckId.toString()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historia IA'),
      ),
      body: flashcardState.when(
        data: (flashcards) {
          final storyState = ref.watch(storiesProvider(flashcards));
          return storyState.when(
            data: (story) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  story,
                  style: const TextStyle(
                    fontSize: 19.0,
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          );
        },
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
