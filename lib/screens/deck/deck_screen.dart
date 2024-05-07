import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/data/deck_datasource.dart';
import 'package:flutter_application_1/providers/user_state.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckScreen extends ConsumerWidget {
  const DeckScreen({super.key});
  static const String name = "DeckScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(authProvider).tokens?['username'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decks'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getDecks(username!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final deckList = snapshot.data!;
            return ListView.builder(
              itemCount: deckList.length,
              itemBuilder: (context, index) {
                final deckName = deckList[index];
                return Card(
                  child: ListTile(
                    title: Text(deckName),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.pushNamed(FlashcardScreen.name, extra: deckName);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(DeckCreatorScreen.name);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
