import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/widgets.dart';

class DeckScreen extends ConsumerWidget {
  const DeckScreen({super.key});
  static const String name = "DeckScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).tokens?['user_id'];
    final deckState = ref.watch(deckProvider(userId!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(deckProvider(userId).future),
        child: deckState.when(
          data: (deckList) => ListView.builder(
            itemCount: deckList.length,
            itemBuilder: (context, index) {
              final deckName = deckList[index].name;
              final deckId = deckList[index].deckId.toString();
              return DeckCard(deckName: deckName, deckId: deckId);
            },
          ),
          error: (error, _) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const PopScope(
                child: CreateDeckDialog(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

 //Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)