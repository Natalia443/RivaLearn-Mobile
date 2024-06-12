import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/widgets/create_story_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoriesDeckSelectionScreen extends ConsumerWidget {
  const StoriesDeckSelectionScreen({super.key});
  static const String name = "StoriesDeckSelectionScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).tokens?['user_id'];
    final deckState = ref.watch(deckProvider(userId!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Deck'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(deckProvider(userId).future),
        child: deckState.when(
          data: (deckList) => ListView.builder(
            itemCount: deckList.length,
            itemBuilder: (context, index) {
              final deckName = deckList[index].name;
              return Card(
                child: ListTile(
                  title: Text(deckName),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PopScope(
                          child: CreateStoryDialog(deck: deckList[index]),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
          error: (error, _) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
